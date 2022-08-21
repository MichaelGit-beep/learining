# Starting The Consul Process
1. Download consul binary 
2. Create config file
```
$ cat /etc/consul.d/consul.hcl 
log_level  = "INFO"
  server = true
  bootstrap_expect = 1
  ui_config {
    enabled = true
  }
  datacenter = "consul-cluster"
  data_dir           = "/opt/consul/data"

  client_addr    = "0.0.0.0"
  bind_addr      = "10.11.12.8"
  advertise_addr = "10.11.12.8"
```
3. Run consul agent with service manager(systemd) and point to config file 
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

4. Enable and start consul service
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
3. Chech members
```
consul members
```

## `run in dev mode`
- No persistency
- No security
- Connect is enabled(service mesh)
- gRPC port default to 8502
```
consul agent -dev
```
