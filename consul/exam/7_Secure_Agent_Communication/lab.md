1. Create CA certificates on one of consul server. CA private key should kept in safe place, and public shoud be distributed to all agents in the cluster so they could validate each other. All agents certificates should be issued by this CA.
```
$ consul tls ca create
==> Saved consul-agent-ca.pem
==> Saved consul-agent-ca-key.pem

```

2. Create Agent Server certificate(will inclde CN server) to pass verify_server_hostname validation. USE YOUR DC name
```
$ consul tls cert create -server -dc dc1
==> WARNING: Server Certificates grants authority to become a
    server and access all state in the cluster including root keys
    and all ACL tokens. Do not distribute them to production hosts
    that are not server nodes. Store them as securely as CA keys.
==> Using consul-agent-ca.pem and consul-agent-ca-key.pem
==> Saved dc1-server-consul-0.pem
==> Saved dc1-server-consul-0-key.pem

openssl x509 -in my-dc-1-server-consul-0.pem -text -noout

```
2.1 Create Client certificate (Will not include server in CN)
```
$ consul tls cert create -client
==> Using consul-agent-ca.pem and consul-agent-ca-key.pem
==> Saved dc1-client-consul-0.pem
==> Saved dc1-client-consul-0-key.pem
```
3. Distribute CA public cert and server cert/key to all servers in the cluster
```
scp consul-agent-ca.pem dc1-server-consul-0.pem dc1-server-consul-0-key.pem consul-server-2:/etc/consul.d/
```

4. Edit consul server config to include certificate
```
datacenter = "my-dc-1"
data_dir = "/opt/consul"
client_addr = "0.0.0.0"
ui_config{
  enabled = true
}
server = true
connect {
  enabled = true
}
retry_join = ["10.0.0.82", "172.29.29.160"]
bind_addr = "172.30.30.160" # Listen on all IPv4
advertise_addr = "172.30.30.160"
enable_local_script_checks = true
enable_local_script_checks = true
verify_incoming = true
verify_outgoing = true
verify_server_hostname = true
ca_file = "/etc/consul.d/consul-agent-ca.pem"
cert_file = "/etc/consul.d/my-dc-1-server-consul-0.pem"
key_file = "/etc/consul.d/my-dc-1-server-consul-0-key.pem"
```

5. Start the cluster

# Client configuration
You can manually distribute client cerficates to every client, or use `auto_encrypt` option, it will distribute certificates automatically and store them in memory. To use this feature need to enable `auto_encrypt` in `server` configuration as well. `verify_incoming` is false since this option is refered to RPC, API, and RAFT traffic, client is not use them, relevant only for servers. 
```
verify_incoming = false
verify_outgoing = true
verify_server_hostname = true
ca_file = "/etc/consul.d/consul-agent-ca.pem"
auto_encrypt = {
  tls = true
}
```