# mTLS - Mutual TLS 
In a classic `TLS`(one way) the process of validation is performed by client. Client validate that the public key of server is sign by trusted authority. 

Server side is not involve some certificate validation for the client, because client usually authenticating on the server, for example using username and password, so for server it is enough to asssume that the client authenticity is proven. 

In mTLS model, certificate validation is two side, additionaly to client, server also validate the client public key, to ensure that it is signed by trusted CA. 
1. Client send the message to start session to the server.
2. Server sends his public key to the client.
3. If client successed to validate authenticity of the server. He sends back to the server his own public key and symetric key for the current session, encrypted using public key of the server.
4. Server validate that client public key is signed by trusted CA. 
5. All cumunication during this session is encypted using symmetric key sended by client. 


# mTLS in K8S
- Implemented via third party pools like `Istio`

- Modes.
1. Permissive / Oppurtunistic - Can allow plain text traffic within the apps, if for example external application communicates database on k8s cluster, and don't has istio sidecar to implement mtls.
2. Enforce / Strict - only mTLS
