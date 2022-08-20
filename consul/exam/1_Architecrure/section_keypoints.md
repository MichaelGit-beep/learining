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

# Service Configuration
Consul provides a distributed K/V store that replicated over all Consul servers.

Application can access K/V via CLI, API, or UI. 

Make sure to enable ACLs to restics access(Objective 8).

- Object type is not restricted. The only restriction is for the max size - 512 KB
- Unstructured, however, you can use / to separate keyname to emulated directory hierarchy. This is verry different from Vault KV, Where / signifies a path

webapp/admin/password=255
webapp/admin/maxval=10
webapp/user/feature=TRUE





