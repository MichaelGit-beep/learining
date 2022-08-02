# Generate CA certs to sign all cluster certificates
- Generate private key (ca.key)
```
openssl genrsa -out ca.key 2048
```
- Generate CSR(certificate signing request ca.csr)
```
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
```
- Create signed public key(ca.crt) with 60 days validity by signing CSR 
```
openssl x509 -req -days 60 -in ca.csr -signkey ca.key -out ca.crt
```

# Generate Cluster Admin user certificates
- Generate private key 
```
openssl genrsa -out admin.key 2048
```
- Generate admin user CSR
```
openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:admin" -out admin.csr
```
- Signing admin CSR with ca.key generated early
```
openssl x509 -req -days 60 -in admin.csr -signkey ca.key -out admin.crt
```

# View Certificate Detail
```
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout 
``` 
# View CSR Detail
```
openssl req -text -noout -verify -in some.csr
``` 

<hr>

## Notes
> All system component like - controller-namager, scheduler should add system: to their /CN to csr "/CN=system:controller-manager" "/CN=system:kube-scheduler"
>
> etcd needs its own set of certificates along with its own CA
>
> kubelet's certificates should contain in their csr "/CN=system:node:nodename"

<hr>

# Certificate API - Approve clients CSR via kubernetes api


# Read Demo hoto add user to k8s
```
openssl genrsa -out 60099.key 2048

openssl req -new -key 60099.key -out 60099.csr

openssl x509 -req -in 60099.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out 60099.crt -days 500
````

