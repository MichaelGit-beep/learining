Prepequisites - /usr/bin/curl, docker

docker run -d -p 80:80 httpd

docker run -d -p 81:80 httpd

consul agent \ 
    -server \
    -bootstrap-expect=1 \
    -node=agent-one \
    -bind=10.0.0.82 \
    -data-dir=/tmp/consul \
    -config-dir=/etc/consul.d 

curl 'http://localhost:8500/v1/health/service/web?passing' -- view healthy instances will be only one

dig @127.0.0.1 -p 8600 web.service.consul # -- Will return only healty endpoints

curl http://localhost:8500/v1/catalog/service/web # -- View all instances