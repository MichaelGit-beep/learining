# ACL

https://www.consul.io/docs/security/acl

https://learn.hashicorp.com/tutorials/consul/access-control-setup-production?in=consul/security


Optional built-in feature of COnsul
- Controls acess to data and the Consul API
- Relies on tokens that assosiated with policies which define access

## Key components of the ACL systems
- Tokens - a bearer token used during the UI,CLI,API
- Policy - Grouping of rules that determine fine-graned rules to be applied to token
- Roles - Group of policies that applied to many tokens 
- Service Identities - policy template to link a policy to a token or role. Uses in service mesh.

## Service Identities 
- An ACL policy template that links a policy for services in Service Mesh(connect)
- Helps services/sidecats to be discovered and easy discover other services
- Can be used on token and roles
- Applies preconfigured ACL rules

## Service Identities Composed of:
- Service - the name of the service 
- DC - the list of DC that policy is valid for

## Roles
- A names set of policy and service identiry 
- Sort of a grouping of miltiple policies and service identities that can be assigned to many tokens
- Composed of:
    - ID
    - Name
    - Secription
    - Policy set - a list of policies to apply to the role
    - Service identities - a list of service identiries for the role


# Enable consul ACL System
- Not enabled by default
- Enabled in the agent configuration of server and clients
- Configuration parameters include default policy and other parameters

Should be added to agent configuration(server and client)
```
acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
}
```

# Bootstraping the ACL system
- Required administrative action before ACL system can be user
- Usually done one time during initial configuration
- default_policy should be a set to Allow during bootstraping and configuration phase
- Bootstrapping create the bootstrap/master token and the anonnymous token
- Greates the Global Management Policy - root policy, provides unrestricted access to everything to tokens assigned to it.

## Enabling process
1. Provision the cluster with ACL enabled
2. Bootstrap the ACL system 
3. Create policies
4. Create tokens
5. Configure Agents/Clients with tokens
6. Update default policy to Deny

# Policies
- Named set of rules that a token is bounded py(policies are attached to tokens)
- Policies can be attached to multiple tokens
- Multiple policies can be attached to one token
- Include: 
  - ID - automatically provided
  - Name 
  - Description
  - Rules
  - Datacenter - the DC the policy valid for
  - Namespace - the NS policy resides in(Ent feature)

## Default Policies
Global-Management 
- Unrestricted access to Consul
- Assigned the reserved policy ID of 000000-00000-000-000000001
- Cannot be deleted, and modified, can be renamed
- Assigned to the bootstrap/master token upon ACL system bootstrapping process


