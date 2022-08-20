# Run agent
- Run consul agent in dev mode
```
consul agent -dev -node agent1
```
*-node could be used in order to change nodename in a case that it is complex and dns depended*
- View member
```
consul members
```
- Check consuls agent dns
```
dig @127.0.0.1 -p 8600 agent1.node.consul
```
- Leave datacenter 
```
consul leave
```

# Register service by definition file
1. Create a dir
```
mkdir consul.d
```
2. Create a service definition file
```
cat <<EOF> consul.d/web.json

{
  "service": {
    "name": "web",
    "tags": [
      "rails"
    ],
    "port": 80
  }
}

EOF
```
3. Start consul agent with specified config dir
```
consul agent -dev enable-local-script-checks -config-dir=./consul.d
```
4. Check that service is registered in consul's DNS. Use SRV to yield SRV record in addition to A
```
dig @127.0.0.1 -p 8600 web.service.consul SRV
```
5. Query DNS to return services by tags
```
dig @127.0.0.1 -p 8600 rails.web.service.consul SRV
```
6. Query HTTP API to return all instances
```
curl http://localhost:8500/v1/catalog/service/web
```
6. Query HTTP API to return only healthy instances
```
curl 'http://localhost:8500/v1/health/service/web?passing'
```
7. Update service configuration - Add health check
```
echo '{
  "service": {
    "name": "web",
    "tags": [
      "rails"
    ],
    "port": 80,
    "check": {
      "args": [
        "curl",
        "localhost"
      ],
      "interval": "10s"
    }
  }
}' > ./consul.d/web.json

```
- reload configs 
```
consul reload
```
- Check that DNS returns only healthy instances - it should return nothing since health check defined to service is not pass
```
curl 'http://localhost:8500/v1/health/service/web?passing'
dig @127.0.0.1 -p 8600 web.service.consul
```