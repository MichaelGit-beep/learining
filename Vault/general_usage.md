# **Run the server**
> Will be displayed Root token
```
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_DEV_ROOT_TOKEN_ID="s.0Rlzb1GgPUeDclNP1WhkomL4"
export VAULT_TOKEN="s.4fUAl4ZRPZA4G2ZaMQMnfpG2"
vault login root
```

## Opend another consol
>export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_DEV_ROOT_TOKEN_ID="s.0Rlzb1GgPUeDclNP1WhkomL4"
export VAULT_TOKEN="s.4fUAl4ZRPZA4G2ZaMQMnfpG2"


## Vault autocompletion
```
$ vault -autocomplete-install
$ bash 
$ vault TAB-TAB
agent      auth       delete     lease      login      namespace  path-help  policy     read       server     status     unwrap
audit      debug      kv         list       monitor    operator   plugin     print      secrets    ssh        token      write

```
## Check status of Vault server
>vault status

## Create secret
>write multiple secrets -->
vault kv put secret/hello foo=notworld bar=nothello
>
>secret can be rewrited  -->
vault kv put secret/hello foo=world bar=hello


## Get secret
>vault kv get secret/hello

## Get secret value directly
>vault kv get -field=foo secret/hello

## Get secret value directly with json
>vault kv get -format=json secret/hello | jq -r .data.data.foo


## Delete secret
>vault kv delete secret/hello 

<br><br><br><br>



# **Vault Engine Path**
```
This is some kind of plugins htat extend vaults ability. Each engine is a 
separate instance. Engines refered virtual filesystem. 
```
## Enable secret engine at different path 
>vault secrets enable -path=jsec/ kv
>
>vault kv put jsec/secrets var=value
>vault kv put jsec/general var=value
>
>vault kv get jsec/secrets
>vault kv get jsec/general

## Get enabled engines list
>vault secrets list

## Dissalbe secret - removes all data
>vault secrets disable moo

<br><br><br><br>

# **Dynamic Secrets** 
>Dynamicly create IAM User with EC2 Full access 
## Enable AWS secrets engine and add AWS access keys to secrets engine
```
vault secrets enable -path=aws aws 
export AWS_SECRET_ACCESS_KEY=<aws_secret_key>
export AWS_ACCESS_KEY_ID=<aws_access_key_id>

vault write aws/config/root \
    access_key=$AWS_ACCESS_KEY_ID \       
    secret_key=$AWS_SECRET_ACCESS_KEY \
    region=us-east-2
```
## Configure role - Vault can create user and role by contacting AWS api
```
vault write aws/roles/my-role \
        credential_type=iam_user \
        policy_document=-<<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1426528957000",
      "Effect": "Allow",
      "Action": [
        "ec2:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
```
You just told Vault:
> When I ask for a credential for "my-role", create it and attach the IAM policy { "Version": "2012..." }.
## **Access AIM User creds - This will create temorary user in AWS and bind it to the role with EC2 Access. This creds will be automatically revoked after lease time, or it can be revoked manually anytime**
> vault read aws/creds/my-role
>
> vault lease revoke aws/creds/my-role/0bce0782-32aa-25ec-f61d-c026ff22106

<br><br><br><br>
# Built-it Help
## It is possible to get the info regarding created vault engine path
```
vault secrets enable -path=aws aws
vault path-help aws
```
<br><br><br><br>
# Token Authentication
### Token authentication is automatically enabled. When you started the dev server, the output displayed a root token. The Vault CLI read the root token from the $VAULT_TOKEN environment variable. This root token can perform any operation within Vault because it is assigned the root policy. One capability is to create new tokens. Created token will inherit policy from parent. 

## Create new token
>**vault token create**
```
Key                  Value
---                  -----
token                s.zX18FUeLzG5Zu0lKgaq4bUvc
token_accessor       6yjbTz1nAKwyqctnSqvGpCot
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]
```
## Login with this token
> vault login s.zX18FUeLzG5Zu0lKgaq4bUvc
## Token can be exported as envieronment variable - take precedence over login specified token
> export VAULT_TOKEN=s.zX18FUeLzG5Zu0lKgaq4bUvc
## Check the token info, applied policy etc.
>vault token lookup
## Revoke this token
>vault token revoke s.zX18FUeLzG5Zu0lKgaq4bUvc

<br><br><br><br>
# Authentication with GitHub Organization

>vault auth enable github  

## Enable to auth to all members from "cooldevdev" GitHub Org. 
>
> vault write auth/github/config organization=cooldevdev 

## Bind the authentication policy of "default and application" to engineering team from github organization.

>vault write auth/github/map/teams/engineering value=default,applications 


## View all auth methods
>vault auth list
## Login with GitHub token
>vault login -method=github
```
[redhat@srv-1 ~]$ vault login -method=github

Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                    Value
---                    -----
token                  s.WucdgQ8thJ8tCS2dGcnFTaxJ
token_accessor         LNlFVdg7assUJ9YaXS7ENZjQ
token_duration         768h
token_renewable        true
token_policies         ["applications" "default"]
identity_policies      []
policies               ["applications" "default"]
token_meta_org         cooldevdev
token_meta_username    MichaelGit-beep

```
## Revoke all tokens generated the github auth method.
>vault token revoke -mode path auth/github
## Disable the github auth method.
>vault auth disable github

<br><br><br><br>

# Policy, authorization
> While Authentication reffered to "Who can enter to the system", Authoriration mean "What person allow to do in the system"
>
> Vault policy specified in HCL format, but it is JSON compatible. The most specific rule is prefered. 

<br>

### **With this policy, a user could write any secret to secret/data/, except to secret/data/foo, where only read access is allowed. Policies default to deny, so any access to an unspecified path is not allowed. User will not have the ability to read secrets from nowery exept secret/foo, however user will not be able to create and update secrets in this path**
```
# Dev servers have version 2 of KV secrets engine mounted by default, so will
# need these paths to grant permissions:
path "secret/data/*" {
  capabilities = ["create", "update"]
}

path "secret/data/foo" {
  capabilities = ["read"]
}
```

## View the policy rules
> vault policy list

>vault policy read default

## Write rule to policy 
Policies can be readed from stdin or from file

> vault policy write -h  # Will show examples 

## Create a new policy from stdin
```
$ vault policy write my-policy - << EOF
# Dev servers have version 2 of KV secrets engine mounted by default, so will
# need these paths to grant permissions:
path "secret/data/*" {
  capabilities = ["create", "update", "read"]
}

path "secret/data/foo" {
  capabilities = ["read"]
}
EOF
```
## Create a new token and bind it to the policy
```
$ vault token create -field token -policy=my-policy
OR
export VAULT_TOKEN="$(vault token create -field token -policy=my-policy)"
```
## View the currently applied Policy to your Token
```
$ vault token lookup | grep policies
policies            [default my-policy]
``` 
