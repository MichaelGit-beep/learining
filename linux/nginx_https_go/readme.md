# Generate private key (ca.key)
openssl genrsa -out ca.key 2048
# Generate CSR(certificate signing request ca.csr)
openssl req -new -key ca.key -subj "/CN=CA" -out ca.csr
# Create signed public key(ca.crt) with 60 days validity by signing CSR 
openssl x509 -req -days 60 -in ca.csr -signkey ca.key -out ca.crt



# --------GENERATE Nginx key and csr with openSSL-----
openssl genrsa -out nginx-selfsigned.key 2048
openssl req -new -key nginx-selfsigned.key -subj "/CN=UPGRADE-WEB" -out nginx-selfsigned.csr



# ---------Generate nginx private key and CSR with go programm------
go run main.go

# Sign CSR with ca.key.
openssl x509 -req -days 36500 -in nginx-selfsigned.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out nginx-selfsigned.crt


# Build images
docker build -t nginx-selfsigned .

# Run container
docker run -p 443:443 -p 80:80 nginx-selfsigned