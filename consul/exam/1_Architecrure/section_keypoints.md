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

## `Real-time health check`
Local agent running on a consul node perform healthchecks of:
- Node-level health checks(If container is running)
- Application-level health checks(If application is running)

If service health check is failed, trafic will not be sended to this instance, Consul returns endpoints only for healthy instances.


## `Automate networking`
With consul you should not implement IP-based or firewall-based rules. Consul provides and abstraction level to confugure the high lavel access rules to the services, consul will handle IP,Firewall rules for all instances of the service.
This is called identity-based authorization. 

`Rule example: `<br>
Webservice allowed to talk to DB service.

Additionally consul can implement traffic shaping for different instances of the same service by configuring weight. 

Provides great visibility of L7 statistics, by Envoy, to track how exactly traffic is going within the services. 

## `Service Discovery - Multi-DC`
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
## `Consul agent roles`
Machine runnin consul considered as `Consul Agent`. Agent can run as `Server, Client.`

Server - Server contain all information about the cluster, and replicates it within other masters.<br>
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


## `Single Datacenter`
It is a single set of Consul Servers and Clients, grouped by some aspect, like location, Cloud Region etc.

- Single-Cluster
- Private
- Low latency
- High bandwidth
- Contained in a single location
- Multi-AZ is acceptable
- Uses the LAN gossip pool

## `Multi-Datacenter`
Multiple Consul clusters that interracting with different clusters, main purpuse that information about registered services is shared between DC, it can provide HA functionality. In case that there is no healthy instances of some app in main cluster, but there is additional cluster with healthy instance.

- Multi-cloud, multi-region, multi-location
- Multiple cluster
- Uses the WAN gossip pool
- Communates bia WAS or Internet
- WAB federatuib through mesh gateway

# Key Protocols
## `Consensus protocol(Raft)`: 
1. Only between Consul Servers. 
2. Leader election - One leader per cluster
3. Quorum establishin - Majority of members of peer set. (n+1)/2
4. Maintaining committed log entries across server nodes:

### `Log:`
- Maintaning by cluster leader
- Primary unit of work - an ordered sequence of entries. 
- Entries can be a cluster change key/values changes
- All members must agree on the entries and their order to be conisidere a consistent log

### `Peer Set:`
- All members participating in log replication, only server nodes

### `Server Node Status:`
- Follower - Default state. If no leader found, it can vote to be a leader or vote for another node to promote it to be a leader. Responsible for accepting logs from the leader, forwaring RPC request to the leader.
- Candidate - Temporary mode during voting for leader
- Leader - Provide log consistency, only leader allowed to change log entries. Replicates log to all follower nodes. 

### `Leader Election:`
- Leader sends heartbeat to follower nodes accordingly to it timeout
- Each server has a randomly assigned timeout (e.g. 150ms - 300ms). This is the key point of leader election. 
- If a heartbeat isn't recieved from the leader, an election takes place
- The node changes its state to candidate, votes for itself, and issues a request for votes to establish majority.
## `Gossip Protocol(Based on serf)`:
1. Uses by Consul Servers and Client cluster wide
2. Uses to broadcast statuses, 
3. Connectivity failures, 
4. Share cluster members. 
5. Uses two gossip pools:
- `WAN - between DC`. Separate, globally unique pool. All servers participate in the WAN pool regardless of datacenter. Allows servers to perfrom cross datacenter requests. Assists with handling single server or entire datacenter failures.
- `LAN - Within the cluster`. Enable consul members to discover each other. Failured detection are shared by members of the entire cluster .

# Network Traffic & Ports
- All communication is HTTP and HTTPS
- Communication protected by TLS and gossip key

## `Ports`: Default values. Coud be changed. 
- HTTP API and UI - 8500/tcp
- LAN Gossip - 8300/tcp 8300/udp
- WAN Gossip - 8302/tcp 8302/udp
- RPC - 8300/tcp
- DNS - 8600/tcp 8600/udp
- Sidecal Proxy - 21000 - 21255

## `Accessing Consul`
- API can be accessed by ane machine (assuming network/firewall)
- CLI can be accessed and configured from any server node
- UI can be enabled in the configuration file and accessed from anywhere

# High Availability
## `Quorum`
 To keep cluster healthy it is important to have a quorum of Consul Servers. Quorum this is majority of nodes `(N+1)/2. With 5 Servers you can loose 2 and still have the quorum`. Recommendation is have at lease 3,5,7,9 nodes in cluster env, however up to 7 nodes Raft relication communication can affect additional load. 

## `Enhanced Read Scalabilty (Consul Interprise feature)`
It is possible to add Read-Only Consul Server that is Non-Voting member, however it is contain the most relavant Log since it is participate in replication.

## `Voting vs Non-Voting Members`
Is not participate in leader election and not affecting the quorum. Can be setted up as non voting by adding `non_voting_member True` to config file, or add `-non-voting-member/-read-replica` to agent start command

## `Redundancy Zones (Interprise Features)`
This feature allows to add Non-Voting members, but in case when one of Voting server is going down the non-voting server will be promoted to be voting server and maintain the quorum.