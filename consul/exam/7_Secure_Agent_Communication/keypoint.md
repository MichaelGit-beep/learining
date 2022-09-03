# Consul Security
`By default Consul is Not Secure !`

https://www.consul.io/commands/tls/cert#examples

https://www.consul.io/docs/security

https://www.consul.io/docs/security/encryption

# Security Threat Model
1. `Gossip Protocol Encryption` - Possible to encrypt agent communication with symetric keys
2. `Buil-it ACL System` - Built-in system, not enabled by default. Protect data and APIs. Possible to enable in Agent config file.
3. `Consul Agent Communication` - It is possible to provide CA bundle to every Consul agent to secure RPC,RAFT(consensus) and API comminucation. Should be enabled in the server configuration file, 
4. `mTLS` for Authenticity + Encryption - Uses for services mesh(`consul connect`), encrypt all traffic between the services and porvide authentication by validating certificates issued by CA, manage authorization by lavarege intention.
5. `Certirifca Authority` - Consul can become CA, or it is possible to integrate it with Vault or some thing else, enabled if `connect` is enabled without specifying a CA provider. Consul can automatically distribute client certificates(automated), or you can do it manually. All the certificates must be signed bu the same CA. You can update to a new provider at any time.
There are 3 types of certificates that could be created manually:
    - `Server` - consul tls cert create -server
    - `Client` - consul tls cert create -client
    - `CLI` - consul tls cert create -cli
    
# TLS Encryption Settings
The primary agent configuration when working with Consul TLS:
- `verify_server_hostname` (default false) - All outgoing connections perform hostname verification. Ensures that servers have a certificate valid for the server and issued to `server.(dc-name).(domain)`. Ensures that a client cannot modify the Consul agent config and resetart it as a server to replicate all information from masters. Without this setting, Consul only verified that the cert is signed by a trusted CA. 
    - Consul CA server certificate will include proper hostname by default
    - If you are using your own CA to create certificates for Consul, you MUST include server.(dc-name).(domain)


- `verify_incoming` (default false) 
    - Requires that all incoming connections use TLS
    - The TLS cert must be signed by a CA included in the ca_file or ca_path
    - Valid for API and RPC communication
    
- `verify_outgoing` (default false)
    - Requeres that all outgoing connections use TLS
    - The TLS cert must be signed by a CA included in the ca_file or ca_path
    - Applies to both - clients and servers as each will make outgoing connections. 

