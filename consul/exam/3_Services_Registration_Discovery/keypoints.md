# Registering Services and Use Service Discovery


### Table of Content
1. [Why to Register](#why-to-register)
2. [How To Register](#how-to-register)
3. [Creating Definition File](#creating-definition-file)
4. [High-Availability and Elasticity](#high-availability-and-elasticity)
5. [Configuring Health Checks](#configuring-health-checks)
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