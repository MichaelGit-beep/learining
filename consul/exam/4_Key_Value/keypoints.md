# Key/Valu Store

[General Info](https://www.consul.io/docs/dynamic-app-config/kv)

[KV API documentation](https://www.consul.io/api-docs/kv)

[KV Interaction with CLI](https://www.consul.io/commands/kv)

[Consul Watch](https://www.consul.io/docs/dynamic-app-config/watches)

Centrilized K/V store that allows users to store objects
- Distributed arcitechture - data is replicates across all agents
- Always enabled 
- Can store any type of data
- Can be accesible from UI,API,CLI

## Table of Content
1. [Use Cases](#use-cases)
2. [What is Not ](#what-is-not)
3. [Additional Information about Consul KV](#additional-information-about-consul-kv)
4. [Designing the KV Structure](#designing-the-kv-structure)
5. [How To Use](#how-to-use)
5. [Limit Access to the K/V Store](#limit-access-to-the-kv-store)
6. [Monitor Changes Watch](#monitor-changes-watch)
7. [Monitor Changes Envconsul](#monitor-changes-envconsul)
8. [Consul Template](#consul-template)

## Use Cases
- Accessed by the application at runtime
- Accesible by both server and client agents(considering ACL)

## What is Not
- Not a full databe like DynamoDB
- Not an encrypted K/V store 
- Does not have a dir structure
    - Does sopport using / to organize data
    - / is treated like any other character
    - Example: `kv/app01/key`, `web/api/access `

- Consul K/V data is store is a single DC - no built-it replication between datacenters

## Additional Information about Consul KV
- Object size limitation: 512 KB per objects
- Backup and Recovery
    - Use `consul snapshot save` command
    - Use Consul snapshot agent(Enterprise)

## Designing the KV Structure
- Design yout K/V struct bvefore you start using it
- Considered to use tree like structure, for everty application
```
# DB APP
prod/db/key
prod/db/setting
prod/db/limit

# Web App
prod/webapp1/connectiontodb
```

## How To Use
### API
- Create a key 
```
curl \
    --request PUT \
    --data @contents \
    http://127.0.0.1:8500/v1/kv/my-key

curl \
    --request PUT \
    --data 'somevalues' \
    http://127.0.0.1:8500/v1/kv/my-key
```
- Read a Key `Value is a base64-encoded blob of data.`
```
curl \
    http://127.0.0.1:8500/v1/kv/my-key

[
  {
    "CreateIndex": 100,
    "ModifyIndex": 200,
    "LockIndex": 200,
    "Key": "zip",
    "Flags": 0,
    "Value": "dGVzdA==",
    "Session": "adf4238a-882b-9ddc-4a9d-5b6758e4159e"
  }
]
```
- Delete
```
curl \
    --request DELETE \
    http://127.0.0.1:8500/v1/kv/my-key
```
### CLI
- Create
```
consul kv put dev/db/key key12312aasdf
```
- Get
```
consul kv get dev/db/key
```
- Delete
```
consul kv delete dev/db/key
```
- Export a tree from the KV store as JSON
```
$ consul kv export apps/
[
        {
                "key": "apps/eCommerce/database",
                "flags": 0,
                "value": "bXlkYXRhYmFzZQ=="
        },
        {
                "key": "apps/eCommerce/database_host",
                "flags": 0,
                "value": "Y3VzdG9tZXJfZGI="
        }
]
```
- Import a tree stored as JSON to the KV
```
consul kv import @/root/backup.json

cat values.json | consul kv import -

consul kv import "$(cat values.json)"

cat values.json | consul kv import -prefix=sub/dir/ -
```
### UI
- Go to http://consul:8500/ui - KV 

## Limit Access to the K/V Store
- Use Consul ACL
- WIll protect access through all three interfaces

# Monitor Changes Watch
It is poossible to monitor when changes occurs to KV and then perform some prefidined actions to update application with new configuration or some thing else.


`Watch` provides a way to monitor for specific changes in COnsul
- BUild-it to consul
- Once "View" of data is updated, a specific handeler is invoked
    - Script - Can invoke `shell` command
    - Can also hit an HTTP endpoint
- ...or just log in to STDOU

## Watch Types
- Key - Watch a specific KV pair
- keyprefix - Watch a prefix in KV 
- services - watch a list of available services
- nodes - watch the list of Nodes
- service - watch the instance of a service
- checks - watch the value of healthchecks
- events - Watch for a costum event

## Configuring a Watch
- Agent config file-  Can be added to an agent configuration, causing it to be run once the agent is 
started. This watch will run the sctipt when key `foo/bar/baz` was updated.
`Watches defined in agent config file will be executed only once on agent initialisation.`
    - Can be used to run script that will get configuration from KV and set them as environment variables before starting the service that will be registered in consul catalog aftermath. Applicable to containers as well, but consul agent should run in a container as well. 
```
watches = [
    {
    type = "key"
    key = "foo/bar/baz"
    args = ["/usr/bin/my-service-handler.sh", "-redis"]
    }
]
```
- ...started outside of the agent using the (consul watch) `Watches that executed with consul watch is not a one time execution like watches defined in consul agent config, but it should run constantly. 
`
```
consul watch -type=key -key=foo/bar/baz /usr/bin/my-key-handler.sh
```

# Monitor Changes - Envconsul
Separate binary that runs on Consul Client node where the application is running, it retrieve data from Consul and Vault and set them to envieronment variables so application can seamlessly use it.

```
consul kv put db01/DB_ADDRESS 10.0.0.1

envconsul -prefix db01 env

evn | grep DB

> DB_ADDRESS=10.0.0.1
```

# Consul Template
External binary, that can fetch values from K/V and store them in file on node running consul-template daemon.

https://github.com/hashicorp/consul-template
1. Install
```
wget https://releases.hashicorp.com/consul-template/0.29.2/consul-template_0.29.2_linux_amd64.zip

unzip consul-template_0.29.2_linux_amd64.zip

mv consul-template /bin
```
2. Insert keys to K/V
```
consul kv put apps/eCommerce/environment env1
consul kv put apps/eCommerce/version v1
consul kv put apps/eCommerce/database_host localhost
consul kv put apps/eCommerce/database postgres
```

3. Create template file or download it from https://github.com/btkrausen/hashicorp/blob/master/consul/config.json.tmpl
```
cat <<EOF>> config.json.tmp
environment: {{ key "apps/eCommerce/environment" }}
version: {{ key "apps/eCommerce/version" }}
database_host: {{ key "apps/eCommerce/database_host" }}
database_name: {{ key "apps/eCommerce/database" }}
EOF
```

4. Run consul-template once. `To run in a daemon mode with constantly monitoring changes ommit -once"
```
consul-template -template "config.json.tmp:config.json" -once
```
5. Verify new file
```
[root@srv-1 env]# cat config.json
environment: env1
version: v1
database_host: localhost
database_name: postgres
```