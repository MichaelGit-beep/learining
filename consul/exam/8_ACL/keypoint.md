# ACL

Tokens and policies could be created from UI,CLI,API

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


## Policy Control Levels (Permission)
- `Read` - RO
- `Write` - RW
- `Deny` 
- `List` - List Consul K/V

## [ACL resources Available for Rules `more used `](https://www.consul.io/docs/security/acl/acl-rules)
- ACL - Operations for management the ACL
- Agent - Utility operations in the Agent API
- Events - List and Firing Events in the Event API
- `KEY` - K/V/ Store Operations
- Keyring - keyring operations 
- `Node` - Node-Level Catalog Operations
- Operator - Cluster-Level Operations
- `Services` - Service-Level Catalog operations
- Sessions - Session operations
- Query - Prepared query oprations

Policy example 
```
service "consul-snapshot" {
  policy = "write"
}

key "consul-snapshot/lock" {
  policy = "write"
}

acl = "write"

key_prefix "vault/" {
  policy = "write"
}

# Empty line means ALL
service_prefix "" { 
  policy = "read"
}
```

# [consul policy cli](https://www.consul.io/commands/acl/policy)
`consul acl policy`
- create - create a new policy
- delete - delete
- list - list all
- read - read the detail about the policy
- update - update a policy(default merges th old and new rules)

```
$ consul acl policy create -name "acl-replication" -description "Policy capable of replicating ACL policies" -rules 'acl = "read"'

ID:           35b8ecb0-707c-ee18-2002-81b238b54b38
Name:         acl-replication
Description:  Policy capable of replicating ACL policies
Datacenters:
Rules:
acl = "read"

$ consul acl policy create -name "replication" -description "Replication" -rules @rules.hcl -valid-datacenter dc1 -valid-datacenter dc2

ID:           ca44555b-a2d8-94de-d763-88caffdaf11f
Name:         replication
Description:  Replication
Datacenters:  dc1, dc2
Rules:
acl = "read"
service_prefix "" {
   policy = "read"
   intentions = "read"
}
```

# [consul policy api](https://www.consul.io/api-docs/acl/policies)

## Create a Policy for the Anonymous Token 
Every request without a bearer token used Anonymous token
- You probably have actions that need to be allowed for anonnymous tokens.
  - Query all services for IP/hosts
  ```
  service_prefix "" {
    policy = "read"
  }
  ```
  - Read all prepared query 
  ```
  query_prefix "" {
    policy = "read"
  }
  ```
  - Not to provide token to run a `consul members command`
  ```
  node_prefix "" {
    policy = "read"
  }
  ```

## Create policy for specific Nodes
If you create a policy for particular node, only this node will be able to use the policy using assosiated token with it, it will secure the access to consul if token will be compromised. 
```
node "web-server-1" {
  policy = "write"
}
service_prefix "" {
  policy = "read"
}
```


# [Tokens](https://www.consul.io/commands/acl/token)
Bearer token used to authorize access to consulresources
- attached to a policy or multiple policies
- contains:
  - accessor - name
  - secretid - actual token
  - policy set - bounded policy
  - description 

- `Anonymous token` - Used when no token provided, id 0000000-00-0000-000002
- `bootstrap token` - master token bounded to global-management policy. Could be reseted. Secret ID always unique

`consul acl token`: clone,create,delete,read,list,update

## Use tokens with CLI
1. Set the envieronment variable 
```
export CONSUL_HTTP_TOKEN=df11b8b8-84b2-6b74-2e76-fa52b254e4c7
```
2. Use `-token` argoment with consul command
```
consule members -token df11b8b8-84b2-6b74-2e76-fa52b254e4c7
```
3. Put token into the file and use `-token-file`
```
consul members token file @token.txt
```

## [Use tokens with API](https://www.consul.io/api-docs#authentication)