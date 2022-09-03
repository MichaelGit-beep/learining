1. create file file policy defined
```
# cat rules.hcl

node_prefix "node02" {
  policy = "write"
}
service_prefix "eCommerce-Front-End" {
  policy = "write"
}
session_prefix "" {
  policy = "write"
}
key_prefix "kv/apps/eCommerce" {
  policy = "read"
}
```
2. Create policy
```
consul acl policy create --name="eCommerce" -description="eCommerce App" -rules @rules.hcl
```
3. Get the ID of created policy
```
consul acl policy read  -name eCommerce
```
3. Create token and bound it to thi policy
```
consul acl token create -description "Token for node02" -policy-id "fdd8b0f0-2fc2-b234-68ab-243e0105f8d5"
```