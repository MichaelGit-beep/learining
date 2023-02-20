# Setup SSL enctyption

## Generate certificate 
```
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout node_exporter.key -out node_exporter.crt -subj "/C=US/ST=California/L=Oakland/O=MyOrg/CN=localhost" -addext "subjectAltName = DNS:localhost"

openssl x509 -in node_exporter.crt -text -noout 

$ mv node_exporter.crt node_exporter.key /etc/node_exporter/ 
$ chown nodeusr.nodeusr /etc/node_exporter/node_exporter.key
$ chown nodeusr.nodeusr /etc/node_exporter/node_exporter.crt
```
## Create node exporter config
```
$ vim /etc/node_exporter/config.yml

tls_server_config:
  cert_file: node_exporter.crt
  key_file: node_exporter.key
```
## Update systemd unit to include web.config file 
```
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=nodeusr
Group=nodeusr
Type=simple
ExecStart=/usr/local/bin/node_exporter \
--web.config=/etc/node_exporter/config.yml

[Install]
WantedBy=multi-user.target

curl -k https://localhost:9100/metrics
```
## Copy public cert to prometheus server and enable https as a default scheme for this scraping job
```
$ scp root@node01:/etc/node_exporter/node_exporter.crt /etc/prometheus/node_exporter.crt
$ vi /etc/prometheus/prometheus.yml 

scrape_configs:
  - job_name: "nodes"
    scheme: https
    tls_config:
      ca_file: /etc/prometheus/node_exporter.crt
      insecure_skip_verify: true
    basic_auth:
      username: prometheus
      password: BCadmin!
    static_configs:
      - targets: ["node01:9100", "node02:9100"]

```

# Setup authentication
## generate hash with apache2-utils from your password
```
apt install apache2-utils

htpasswd -nBC 10 "" | tr -d ':\n'; echo
# Insert the password 
> $2y$10$MJovMAf.voElOKVTBnwXzeot92Ai/5CwzHGLTPsJX.EOgOGsQQply
```
## Update node_exporter config.yml to inclue basic_auth_user info
```
$ vim /etc/node_exporter/config.yml

basic_auth_users:
  prometheus: $2y$10$MJovMAf.voElOKVTBnwXzeot92Ai/5CwzHGLTPsJX.EOgOGsQQply

```
## Update prometheus config scrape job to include basic_auth username and plain-text password
```
scrape_configs:
  - job_name: "nodes"
    basic_auth:
      username: prometheus
      password: BCadmin!
    static_configs:
      - targets: ["node01:9100", "node02:9100"]
```