# Registering Services and Use Service Discovery


### Table of Content
1. [Why to Register](#why-to-register)
2. [How To Register](#how-to-register)
3. [Creating Definition File](#creating-definition-file)
4. [High-Availability and Elasticity](#high-availability-and-elasticity)
5. [Configuring Health Checks](#configuring-health-checks)
6. [Query Services from Consul Catalog](#query-services-from-consul-catalog)
7. [Prepared Queries](#prepared-queries)
## Why to Register

Each service could be registered within Consul catalog with it endpoint, and healthckecs parameters. After registration, service information will be available to obtain via Consul DNS, Consul API, Consul UI. So each service can discover any other service and their endpoints by send requests to Consul node.

## How to Register
- Register is done by Consul local agent(client)
    - HTTP API  https://www.consul.io/api-docs/agent/service#service-agent-http-api
        ```
        $ cat service.json

        {
            "service": {
                "ID": "redis1",
                "Name": "redis",
                "Port": 8000
            }
        }

        $ curl \
            --request PUT \
            --data @service.json \
            http://127.0.0.1:8500/v1/agent/service/register?replace-existing-checks=true
        ```

    - Service Definition File(JSON or HCL). 
    
        Could be provided as config file with Consul agent starting with `-config-file` parameter, to provide multiple config files on startup need to use `-config-dir` arg
    - Run the `consul services register` and provide config file to mannually register the service
    - If you already have running Consul instance fith `-config-dir` you can puth service definition file to that dir and execute a `consul reload` command 
- Service Registration typically happens when a new service is provisioned.
    - Containers is scheduled by K8S
    - Instance is deployed 
    - Jenkins provisions new VMs on a VMware cluster

## Creating Definition File
- Create a file that defines a service to be registered in Consul
- Once registered, the service is added to the Consul service registry as an available only if all healthchecks are passed, or healtchchecks is not defined.
- Parametes included in the service may include: 
    - `"name"` - Logical name of the service. Must be DNS valid name. 
    - `"id"` - Uniqued value peg agent (Name of the node/container, must be unique per agent). If you have multiple instances of the same service, `"name"`  should be the same, but `"id"` should be unique it will be used as different endpoints to load balancing). Must be DNS valid. Default: match "name"
    - `"tags"` - Optional. Can be used to query consul for services with specific tags.
    - `"address"` - IP of application. Default: Will be set to a default agents address
    - `"port"` - PORT of the application.
    - `"checks"`: Health Checs for the Service.
    ```
    "checks":
        [
            {
                "args": ["/usr/local/bin/check_mem.py],
                "interval": "30s"
            }
        ] 
    ```
    - [Service Example](https://www.consul.io/docs/discovery/services#service-definition)
### Default namespace for a registered service.
- *`name`*.service.consul
- web-service.service.consul

## High-Availability and Elasticity
You can register many instances of the same service on different nodes, register them in Cnsul Catalog, and consul will return their endpoint only if healthcheck are passed. 

## Configuring Health Checks
- Determine when the node or servie is healthy
- Can be created via API or a Service Config
- May include
    - Name
    - Arguments based on type of check
    - Interval 
    - Timeout
    - Additional parameter based on check
- A service may have multiple health checks, even if one is failed - service consideren unhealthy and marked as `CRITICAL` and removed from Service Pool
### `Stages`
- On startup service consideren unhealth untill first health check is passed.
- If Health check pass service added to service pool and could be reached by other who is quering Consul DNS or API

### `Types`
- Application-Level(service) health check. Could be configured to service in service definition. 
- System-level(node) health check. CPU, MEM etc. - If whis check is failed, it affects all services running on this node. Could be configured to Agent in config file. 
- 7 Types of Healchecks :
    1. Script - execute a script
    2. HTTP - Perform GET looking for a 2xx return code
    3. TCP - Establish TCP connection
    4. TTL - relies on app to report health to endpoint
    5. Docker health - invoke app in Docker container
    6. gRPC - Probe a gRCP endpoint
    7. Alias - Determine health of another registered service
    8. [Documentation](https://www.consul.io/docs/discovery/checks#checks)

# Query Services from Consul Catalog
All services regardless of where they're running and if they registered in Consul's catalog or not, can query Consul to retrieve endpoint of all registered services. 

Example: Running WebApp may need to connect to DB, and all what this app need to do this is query Consul and it will get endpoint of healthy instance of this service. 

It is possible to retrieve registered services, their health and endpoints from Consul UI, CLI, API. Most common use case this is to configure DNS to pass all querys for `*.consul` to Consul's DNS server. However API request also can be used, but it will require application refactoring to be aware of Consul and send requests to it and parse output from Consul API.

- query consul's DNS
```
dig @127.0.0.1 -p 8600 web.service.consul
```
- View registered services with API. Healthy and unhealthy. Under `"ServiceWeights"` you can see how much Nodes are passing their Healthchecks. Pay attention that if node is healthy doens't mean that service is healthy.
```
curl http://localhost:8500/v1/catalog/service/web # -- View all instances
```
- View only healthy services of type `web`
```
curl 'http://localhost:8500/v1/health/service/web?passing' # -- view healthy instances only
```

## Prepared Queries
Allow you to creat and register a more comlex service query so it can be executed later.
### Created by using the `/query` API endpoint
### Consumed by either API or DNS query. (*queryname.query.consul*)

- Allows for richer queries thatn just DNS alone
- Used to filter the results of a service query
- Objects defined at the datacenter level


## Create prepared query
- Define name, and what to lookup, in that case you will query for service namde "front-end-eCommerce", and only for those instancet that have a tags ["v7.05", "production"]. UUID of the query will be printed
```
curl http://127.0.0.1:8500/v1/query \
>     --request POST --data @- <<EOF

{
  "name": "eCommerce",
  "service": {
    "service": "front-end-eCommerce",
    "tags": ["v7.05", "production"]
   }
}

EOF

{"ID":"9d985040-b9b9-e4bc-c934-716ffbb3f0e7"}
```
## View created Querys
```
curl http://127.0.0.1:8500/v1/query | jq
curl http://127.0.0.1:8500/v1/query/9d985040-b9b9-e4bc-c934-716ffbb3f0e7 | jq
```

## Update existing query with API request, Method PUT, need to provide UUID of existing query
1. Retrieve UUID of query to update
```
curl http://127.0.0.1:8500/v1/query # Get UUID

{"ID":"9d985040-b9b9-e4bc-c934-716ffbb3f0e7"}
```
2. Create new query json difinition
```
{
  "name": "eCommerce",
  "service": {
    "service": "front-end-eCommerce",
    "tags": ["v8", "production"]
   }
}
```
3. Update query 
```
curl --request PUT --data @query_file.json http://127.0.0.1:8500/v1/query/9d985040-b9b9-e4bc-c934-716ffbb3f0e7
```
## Execute prepated query
- ###  DNS: eCommerce.query.consul
- ###  API: https://consul:8500/v1/query/UUID/execute `*UUDI of prepared query must be obtained from consul API*`
- Execute Created query and get IP off returnet service From First node
```
$ curl 127.0.0.1:8500/v1/query/9d985040-b9b9-e4bc-c934-716ffbb3f0e7/execute | jq .Nodes[0].Service.Address

"10.0.0.82"

```
- Execute DNS query by predefinded 
```
$ dig @127.0.0.1 -p 8600 eCommerce.query.consul

....(Text ommited)

;; ANSWER SECTION:
eCommerce.query.consul.  0       IN      A       10.0.0.82

....(Text ommited)
```
## Adding Failover Policies
When multiple datacenter are federated, we can extend prepred queries to return services in other datacenter in case there is no healthy instance in the local DC. It is transperent to the application, since it still lookup to the very same query, without awareness of where it is runnig. 



## Types of Failover Policies
[Types Of Failover Policies](https://learn.hashicorp.com/tutorials/consul/automate-geo-failover#failover-policy-types)
1. Static policy - Fixed list of the order of failover
2. Dynamic policy - Send to neqrest DC based on RTT(Round trip time)
3. Hybrid Policy - Use shortest RTT(Round trip time) first, then use other DC

- Failover policies will try to return a LOCAL service first before returning a service from a Federated datacenter
- Each DC will be queried only one time during failover. So while using hybrid Failover Policy Type it will Query Couple nearest DCs, and if some problems occures it will query predifined DC's, but if in predifined list was DCs that failed during RTT test, it will be skipped. 
## Create Failover Policy
This is very same prepared query buth with `Failover` parameters. 

Example of Static Failover
```
$ curl http://127.0.0.1:8500/v1/query \
    --request POST \
    --data @- << EOF
{
  "Name": "banking-app",
  "Service": {
    "Service": "banking-app",
    "Tags": ["v1.2.3"],
    "Failover": {
      "Datacenters": ["dc2", "dc3"]
    }
  }
}
EOF
```

Example of Dynamic Failover Policy. NearestN is define how much DCs to check 
```
"Failover": {
    "NearestN": 2
}
```
Example of Hybrid Failover Policy
```
"Failover": {
    "NearestN": 2,
    "Datacenters": ["dc2", "dc3"]
}
```

# Recap - Compare Options for Querying Services
- DNS - Simple, but Not Flexible
- Prepared Query - Dynamic, but query opnl;y local DC
- Failover Policy - Ideal Solution for Multi-Cloud APPS and multiple DC. 