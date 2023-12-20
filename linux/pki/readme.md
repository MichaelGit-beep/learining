- Generate CA private key (ca.key)
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
- Create self signed certificate without creating csr(MUST if you generating CA, as CA:TRUE extention is mandatory for CA)
```
openssl req -new -x509 -extensions v3_ca -days 3000 -subj "/CN=KUBERNETES-CA" -key ca.key -out ca.crt
```

- Generate client private key (client.key)
```
openssl genrsa -out client.key 2048
```
- Generate CSR(certificate signing request ca.csr)
```
openssl req -new -key client.key -subj "/CN=client" -out client.csr
```

- Sign client's CSR with CA key
```
openssl x509 -req -days 60 -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt
```

- Check client's certificate details and signature
```
openssl x509 -in client.crt -text -noout
openssl verify  -CAfile ca.crt client.crt 
```