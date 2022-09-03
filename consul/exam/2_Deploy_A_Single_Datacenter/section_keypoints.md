# Starting The Consul Process
## 1. Download consul binary 
## 2. Consul Agent Configuration
- Defined in HCL or JSON
- Consul can't be configured with Envieronment variables, only startup arguments or config file.
### `Config file` - It is possible to assign health checks to node, if check is failed all services on it node consudered failed.
```
$ cat /etc/consul.d/consul.hcl 
log_level  = "INFO"
server = true
bootstrap_expect = 3
retry_join = ["172.2.2.152", "172.2.2.151"]
ui_config {
  enabled = true
}
datacenter = "consul-cluster"
data_dir           = "/opt/consul/data"

client_addr    = "0.0.0.0"
bind_addr      = "10.11.12.8"
advertise_addr = "10.11.12.8"

check = {
  id = "web-app"
  name = "Web App Status"
  service_id = "web-app"
  ttl = "30s"
}
```
## `Config file fields`
https://www.consul.io/docs/agent/config/cli-flags
https://www.consul.io/docs/agent/config/config-files
### `Server\Client config options`
- server(bool) - how to run consul agent, server or client
- datacenter(str) - datacenter to join
- start_join/retry_join/auto_join(str) - what other servers/cluster to join
- log_level(string) - level to log(trace,debug,info, etc)
- client_addr - On what IP can recieves the request for API. 
- bind_addr - Internal consul IP for consul agent, default is 0.0.0.0 however, it will exit with error if multiple IP is found. In that case need to specify one IP.
- advertise_addr(str) - Waht IP/interface to use for Consul internal communication. IP that advertised to other consul members, default is to match `bind_addr`, however in scenarious where Consul member is using multiple IP, or placed behind NAT need to specify this one explicitly, if you contacts other members placed behind nat, you need to specify external NAT address, and configure port forwarding on the NAT to forward traffic to consul internal address. 
- encrypt(str) - sercret to use for encryption of Consul traffic(gossip)  32-bytes that are Base64-encoded. Could be created with ` consul keygen`

- data-dir - provide a persistent directory for the anget to store state
### `Service config options` - Used by a clients to register services
- name(str) (must) - logical name of the service
- id(str) - UID for service, must be unique per agent.
- port(int) - what local port is the service running on(80,8080,443)
- check(arg) - define afruments for health check. 

## 3. Run consul agent with service manager(systemd) and point to config file 
```
$ cat /etc/systemd/system/consul.service 
[Unit]
Description="HashiCorp Consul - A service mesh solution"
Documentation=https://www.consul.io/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/consul.d/consul.hcl

[Service]
User=consul
Group=consul
ExecStart=/usr/bin/consul agent -config-dir=/etc/consul.d/
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGTERM
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```
- (Optional)Run consul agent command with flags
```
consul agent -datacenter="aws" -bind="10.0.10.42" -data-dir=/opt/consul -encryp=key -rerty_join="10.0.10.64,10.4.23.98"
```
- Set configuration could be made by `-config-file`(only single config file allowed) or `-config-dir`(allows many config files) arg

## 4. Enable and start consul service
```
systemctl daemon-reload
systemctl enable consul.service 
systemctl start consul.service 
systemctl is-enabled consul.service 
systemctl status consul.service
```

## `Join nodes to cluster`
1. Follow procedure of running consul agent in proper mode(config file)
2. From Consul Server node run join command to join Clients
```
consul join node01 node02 node03
```
3. Chech members, check cluster leader
```
consul members
consul operator raft list-peers
```
4. Leave consul cluster
```
consul leave
```
5. Stop service
```
systemctl stop consul.service
systemctl disable consul.service
```
6. Reload configuration. Certain configuration are not reloadable: ACL Tokens, Checks, Log Level, Node Metadata, Services, TLS configs, Watches. Non-reloadable configuration applied only after consul service restart.
```
consul reload
```
## `Run in dev mode`
- No persistency
- No security
- Connect is enabled(service mesh)
- gRPC port default to 8502
```
consul agent -dev
```

# AddingConsul Agents to the Cluster
### `Consul server can join the cluster using multiple methods`
1. A consul agent can join another node to the cluster(Gossip wil propogate the updated membership state across the cluster)
2. Node can join to another cluster by contaction any member of it.
3. An agent that is already a member can join to a different cluster(Two cluster will be merged into a single)

### `Join with CLI`
Join to the cluster
```
consul join 192.1.1.25 
```
### `Join node with start cluster command` - Will failed if couldn't join node to the cluster, unless using `-retry-join` that will probe couple time.
```
consul agent -server -join 172.2.2.152 172.2.2.151
consul agent -server -retry-join 172.2.2.152
```
### `Join with config file`
```
retry_join = ["172.2.2.152", "172.2.2.151"]
```

### `Cloud Auto-Join`
Prefered method while deploying on public cloud. Will add nodes node with specific tags on it. Require permission to cloud to query cloud API to find needed nodes.
```
consul agent -retry-join "provider=aws tag_key=consul tag_value=true"
```

# Removing Consul Agents from the Cluster
- Graceful leave and shutdown the agent. Affects peer set, hence will cause cluster consensus reconfiguration.
```
consul leave
```
- Clean leaved Consul agents after `consul leave`. After node gracefuly left the cluster, it will apear in a members list with status `left` some amount of time. To prune all left agent forcely, it can also remove failed node from the cluster:
```
consul force-leave -prune left-node-name
```
