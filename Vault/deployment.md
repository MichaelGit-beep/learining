https://learn.hashicorp.com/tutorials/vault/getting-started-deploy?in=vault/getting-started
```
$ touch docker-compose.yml
$ mkdir -p volumes/{config,file,logs}
```
```
$ cat > volumes/config/vault.json << EOF
{
  "backend": {
    "file": {
      "path": "/vault/file"
    }
  },
  "listener": {
    "tcp":{
      "address": "0.0.0.0:8200",
      "tls_disable": 1
    }
  },
  "ui": true
}
EOF
```
```
$ cat > docker-compose.yml << EOF
version: '2'
services:
  vault:
    image: vault
    container_name: vault
    ports:
      - "8200:8200"
    restart: always
    volumes:
      - ./volumes/logs:/vault/logs
      - ./volumes/file:/vault/file
      - ./volumes/config:/vault/config
    cap_add:
      - IPC_LOCK
    entrypoint: vault server -config=/vault/config/vault.json
EOF
```
```
docker-compose up -d
```


# Install vaule CLI https://www.vaultproject.io/docs/install
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN="s.XmpNPoi9sRhYtdKHaQhkHP6x"

# Configure using CLI or webui