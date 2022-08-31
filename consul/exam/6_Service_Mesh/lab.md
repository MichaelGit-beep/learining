# [original lab](https://learn.hashicorp.com/tutorials/consul/service-mesh-with-envoy-proxy?in=consul/getting-started)

1. [Enable service mesh](https://www.consul.io/docs/agent/config/
config-files#connect)

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
cat <<EOF> counting.hcl
service {
  name = "counting"
  id = "counting-1"
  port = 9003

  connect {
    sidecar_service {
        proxy {
            #local_service_address = "10.0.0.82" # Address of sidecar
        }

    }
  }

  check {
    id       = "counting-check"
    http     = "http://localhost:9003/health"
    method   = "GET"
    interval = "1s"
    timeout  = "1s"
  }
}
EOF

consul services register counting.hcl


cat <<EOF> dashboard.hcl
service {
  name = "dashboard"
  id = "dashboard-1"
  port = 9002

  connect {
    sidecar_service {
      proxy {
        # local_service_address = "10.0.0.82" # Address of sidecar
        upstreams = [
          {
            destination_name = "counting"
            local_bind_port  = 5000
          }
        ]
      }
    }
  }

  check {
    id       = "dashboard-check"
    http     = "http://localhost:9002/health"
    method   = "GET"
    interval = "1s"
    timeout  = "1s"
  }
}
EOF

consul services register dashboard.hcl
```


4. Create intention allowind dashboard service to access counting service
```
consul config write - <<EOF 
Kind = "service-intentions"
Name = "counting"
Sources = [
  {
    Name   = "dashboard"
    Action = "allow"
  }
]
EOF
```

5. Start application for registered services:
```
mkdir demp
cd demp/

wget https://github.com/hashicorp/demo-consul-101/releases/download/0.0.3.1/counting-service_linux_amd64.zip

wget https://github.com/hashicorp/demo-consul-101/releases/download/0.0.3.1/dashboard-service_linux_amd64.zip

unzip dashboard-service_linux_amd64.zip
unzip counting-service_linux_amd64.zip

PORT=9002 COUNTING_SERVICE_URL="http://localhost:5000" ./dashboard-service_linux_amd64 &

PORT=9003 ./counting-service_linux_amd64 &
```

6. Start Embeded consul proxy for the services. Need to specify service ID not name.
```
consul connect proxy -sidecar-for counting-1 > counting.log &
consul connect proxy -sidecar-for dashboard-1 > dashboard.log &
```

7. Navigate to localhost:8500 and check that all services are healty

8. Navigate to dashbroard service UI localhost:9002 and check that it can connect to counting service(based on intention allow)

9. Change intention to deny access and check that you can't connect to counting service
```
consul config write - <<EOF 
Kind = "service-intentions"
Name = "counting"
Sources = [
  {
    Name   = "dashboard"
    Action = "deny"
  }
]
EOF
```