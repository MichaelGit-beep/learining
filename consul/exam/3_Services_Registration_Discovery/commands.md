```
consul services register def.hcl
consul reload
consul catalog services
consul services deregister def.hcl

dig @127.0.0.1 -p 8600 web.service.consul # -- Will return only healty endpoints

curl http://localhost:8500/v1/catalog/service/web # -- View all instances

curl 'http://localhost:8500/v1/health/service/web?passing' # -- view healthy instances only

Access UI http://localhost:8500/ui to check 
```