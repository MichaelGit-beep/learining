1. [Enable service mesh](https://www.consul.io/docs/agent/config/config-files#connect)

```
datacenter = "my-dc-1"
data_dir = "/var/consul"
client_addr = "0.0.0.0"
bind_addr = "10.0.0.82" 
advertise_addr = "10.0.0.82"
ui_config{
  enabled = true
}
server = true
connect {
  enabled = true
}
enable_local_script_checks = true
``` 
2. Register two services and sidecar proxy
```
cat <<EOF> front.hcl
service {
    id = "front-server-01"
    name = "front"
    address = "10.0.0.82"
    port = 80
    tags = ["primary"]
    connect {
        sidecar_service {
            proxy {
                local_service_address = "10.0.0.82" # Address of sidecar proxy
                upstreams = [
                    {
                        destination_name = "back", 
                        local_bind_port = 5000
                    }
                ]
            }
        }
    }
}
EOF

consul services register front.hcl


cat <<EOF> back.hcl
service {
    id = "back-server-02"
    name = "back"
    address = "10.0.0.82"
    tags = ["treeee"]
    connect {
      sidecar_service {
        proxy {
            local_service_address = "10.0.0.82" # Address of sidecar 
        }
      }
    }
    port = 81
}
EOF

consul services register back.hcl
```
3. Start Embeded consul proxy for the services. Need to specify service ID not name.
```
consul connect proxy -sidecar-for back-server-02 > backend.log &
consul connect proxy -sidecar-for front-server-01 > front.log &
``