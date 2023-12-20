package main

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"crypto/x509/pkix"
	"encoding/pem"
	"fmt"
	"log"
	"os"
)

func main() {
	keyBytes, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		log.Fatal(err)
	}

	keyFile, err := os.Create("nginx-selfsigned.key")
	if err != nil {
		log.Fatal(err)
	}

	keyPEM := &pem.Block{Type: "RSA PRIVATE KEY", Bytes: x509.MarshalPKCS1PrivateKey(keyBytes)}
	pem.Encode(keyFile, keyPEM)
	template := x509.CertificateRequest{
		Subject: pkix.Name{
			CommonName:         "example.com",
			Country:            []string{"AU"},
			Province:           []string{"Some-State"},
			Locality:           []string{"MyCity"},
			Organization:       []string{"Company Ltd"},
			OrganizationalUnit: []string{"IT"},
		},
		SignatureAlgorithm: x509.SHA256WithRSA,
	}
	csrFile, err := os.Create("nginx-selfsigned.csr")
	if err != err {
		log.Fatal(err)
	}
	csrBytes, _ := x509.CreateCertificateRequest(rand.Reader, &template, keyBytes)
	pem.Encode(csrFile, &pem.Block{Type: "CERTIFICATE REQUEST", Bytes: csrBytes})
	fmt.Println(string(csrBytes))
}
