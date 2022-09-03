# Gossip Encryption

[https://www.consul.io/commands/keygen](Consul Keygen)

[https://www.consul.io/docs/security/encryption](Encryption)

All Gossip communication could be sercured with `symmetric` encryption(shared secret method)

# Configure Gossip encryption
1. Generate 32-Bytes, base64 encoded key with consul
```
consul keygen
```
2. list and manage keys in consul
```
consul keyring
```
3. Add to consul agent configuration `encrypt` parameter, servers and clients
```
encrypt = "asdlkfjasdf7a89sfasdfhasdf87"
```
3.1 Or add `-encrypt` key with consul command


# Configure Gossip encryption on existing cluster without interuptions
1. Generate key
```
consul keygen
```
2. Edit agent config file on every agent(servers and client). To avoid downtime, need to enable encryption step by step, so first we will add `encrypt` key, but dissable incoming and outgoing encryption. After this step agent will be able to decrypt gossip message but will not yet encrypt outgoing messages and will allow unencrypted incomming traffic.
```
encrypt = "asdfasdfklajdf87iasdf"
encrypt_verify_incoming = false
encrypt_verify_outgoing = false
```
3. Restart consul service on every agent
```
systemctl restart consul
```
4. Enable outgoing encryption on every agent and restart the service another time, this will forse node to send encrypted messages but still will allow unencrypted incomming traffic. 
```
encrypt_verify_outgoing = true
systemctl restart consul
```
5. Set to incoming encryption validation to true on every node and restart consul service, this will forse agents to recieve only encrypted traffic and send encrypted traffic. 
```
encrypt_verify_incoming = true
systemctl restart consul
```

## Manage Encryption Keys
All management operation with existing keys could be done with `consul keyring`
- List 
- Distribute - push new keys to all consul agents
- Retire old keys - revoke old keys from consul agents
- Change the key used for encryption

You can have multiple keys, but it is not recommended because consul will make additional attmpts to decrypt incomming traffic with every key. Multiple keys is used during key rotation process. 

# Manage encryption keys. [Key rotation process](https://learn.hashicorp.com/tutorials/consul/gossip-encryption-rotate)
1. Generate new key
```
consul keygen
```

2. Install new key to consul agents
```
consul keyring -install newkey
```

3. Change primary key used for Gossip encription to newly installed
```
consul keyring -use newkey
```
4. Remove the old key from agents
```
consul keyring -list
consul keyring -remove OLDKEY
```
