1. Reconfigure the Consul Agent configuration file to enable Consul ACLs

- a) $ sudo vi /etc/consul.d/config.hcl
- b) add the ACL configuration found in GitHub at
https://github.com/btkrausen/hashicorp/blob/master/consul/config.
hcl
2. Restart the Consul service to pick up the new configuration on both servers
- a) $ sudo systemctl restart consul
3. Validate both servers are back up and running
- a) $ consul members
4. Bootstrap the Consul ACL system
- a) $ consul acl bootstrap
5. Save the bootstrap/master token in a secure place

View tokens providing root token on bootstrap
```
CONSUL_HTTP_TOKEN=df11b8b8-84b2-6b74-2e76-fa52b254e4c7 consul acl token list
```