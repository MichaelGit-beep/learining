# Core features
- Dynamuc Service Registration
- Service discovery
- Distributed Health Checks
- Centrilized K/V Storage 
- ACL
- Segmentation of services
- Cross Cloud/DC Availability
- HTTP API, UI, CLI interface


# Service Discovery
Services authomaticaally registering themselfs in a single registry of consul, thus when serviceA want to talk to serviceB it is always get the enpoint of a healthy node of serviceB.

Benefits:
- Single point of contact for services(Consul implements LB)
- Important for dynamic workload(such a containers)

## *Real-time health check*
Local agent running on a consul node perform healthchecks of:
- Node-level health checks(If container is running)
- Application-level health checks(If application is running)

If service health check is failed, trafic will not be sended to this instance, Consul returns endpoints only for healthy instances.


## *Automate networking*
With consul you should not implement IP-based or firewall-based rules. Consul provides and abstraction level to confugure the high lavel access rules to the services, consul will handle IP,Firewall rules for all instances of the service.
This is called identity-based authorization. 

Rule example: 
Webservice allowed to talk to DB service.

Additionally consul can implement traffic shaping for different instances of the same service by configuring weight. 

Provides great visibility of L7 statistics, by Envoy, to track how exactly traffic is going within the services. 

## *Service Discovery - Multi-DC*
Service discovey is worked seamlessly even within hybrid environments, services can reach each other regrdless where they running, services runnin on local on-prem service, can easily contacts services running in cloud infrastructure untill they're registered in service registry. 

# Service Mesh
Allows services to contact each other securely using mTLS, and per service access controll, to allow only needed communication within the services.

For example when there is WEB, Search, Payment services, you can define that Payment service might be contacted only by WEB service, so in case and Search service will be compromised, it will not be able to compromise Payment service this rules are called `Intention` in Consul. This functionallity provided by sidecar proxy, mostly Envoy proxy, that transperently handle all inbound/outbound traffic to each service instance,

# Service Configuration(K/V)
Consul provides a distributed K/V store that replicated over all Consul servers.

Application can access K/V via CLI, API, or UI. 

Make sure to enable ACLs to restics access(Objective 8).

- Object type is not restricted. The only restriction is for the max size - 512 KB
- Unstructured, however, you can use / to separate keyname to emulated directory hierarchy. This is verry different from Vault KV, Where / signifies a path
```
webapp/admin/password=255
webapp/admin/maxval=10
webapp/user/feature=TRUE
```

# Consul Basics
## *Consul agent roles*
Machine runnin consul considered as `Consul Agent`. Agent can run as `Server, Client.`

Server - Server contain all information about the cluster etc.<br>
Client - Can run as a container, it is running on machine with the workload, it is serves a local application. <br>

Consul agent is platform agnostic and can run the same on different OS `(Lin, Win, MacOS, FreeBSD, Solaris)`
### `Consul Server responsible for:`
- Understending the state of whole cluster
- Manage membership of the cluster
- Maintain quorum
- Register Services
- Acts as a Getaway to other DataCenters
### `Consul Client responsible for:`
- Perform Health Cheks
- Register Local Services and sends this info to Consul Server
- Forwards RPC calls to Server
- Takes part in LAN Gossip Pool
- Almost Stateless

### `Dev mode`
- Running as Consul Server
- Not persistent
- Not scalable
- Not secured


## *Single Datacenter*
It is a single set of Consul Servers and Clients, grouped by some aspect, like location, Cloud Region etc.

- Single-Cluster
- Private
- Low latency
- High bandwidth
- Contained in a single location
- Multi-AZ is acceptable
- Uses the LAN gossip pool

## *Multi-Datacenter*
Multiple Consul clusters that interracting with different clusters, main purpuse that information about registered services is shared between DC, it can provide HA functionality. In case that there is no healthy instances of some app in main cluster, but there is additional cluster with healthy instance.

- Multi-cloud, multi-region, multi-location
- Multiple cluster
- Uses the WAN gossip pool
- Communates bia WAS or Internet
- WAB federatuib through mesh gateway

## *Key Protocols*
- `Consensus protocol(Raft)` - Only between Consul Servers. Leader election, quorum establishing.
- `Gossip Protocol(Cerf)` - Uses by Consul Servers and Client cluster wide, uses to broadcast statuses, connectivity failures, share cluster members. Uses two gossip pools `WAN - between DC` and `LAN - within the cluster`.
