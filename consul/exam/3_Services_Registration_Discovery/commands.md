- Register service with CLI
```
consul services register def.hcl
```
- Reload configuration after adding service definition file to config dir
```
consul reload
```
- View registered services
```
consul catalog services
```
- Unregister sirvice
```
consul services deregister def.hcl
```
- Lookup Consul's DNS for a service healthy endpoints
```
dig @127.0.0.1 -p 8600 web.service.consul # -- Will return only healty endpoints
```
- View registered services with API. Healthy and unhealthy
```
curl http://localhost:8500/v1/catalog/service/web # -- View all instances
```
- View all instances of specific service
```
curl http://127.0.0.1:8500/v1/catalog/service/web
```
- View only healthy services of type `web`
```
curl 'http://localhost:8500/v1/health/service/web?passing' # -- view healthy instances only
```
- Access UI
```
http://localhost:8500/ui to check 
```
- 