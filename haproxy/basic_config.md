## 1. Edit config file /etc/haproxy/haproxy.cfg
>### **Append to the end section with backend and frontend config**

```
frontend my_http_front
        bind *:80
        default_backend my_http_back


frontend my_secret_front
        bind *:9999
        default_backend my_secret_back

backend my_http_back
        balance roundrobin
        server myweb1 10.0.0.101:8082 weight 90
        server myweb2 10.0.0.101:8083 weight 10
        server myweb3 10.0.0.101:8084 weight 10

backend my_secret_back
        server my_secret_web 10.0.0.101:8085

```

## 2. Restart haproxy
```
systemctl restart haproxy
```