
# Create devuser for 1 yeat with peivileges to briefcam namespace only. 
```
openssl genrsa -out devuser.key 2048
openssl req -new -key devuser.key -out devuser.csr -subj "/CN=devuser/O=staff"

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: devuser
spec:
  request: $(cat devuser.csr | base64 | tr -d "\n")
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF


k certificate approve devuser
kubectl get csr devuser -o jsonpath='{.status.certificate}'| base64 -d > devuser.crt

k create role devuser --resource=* --verb=* --namespace briefcam
k create rolebinding devuser --role devuser --user=devuser -n briefcam

# k config set-credentials devuser --client-key=devuser.key --client-certificate=devuser.crt --embed-certs=true
# k config set-context devuser --cluster=kubernetes --user=devuser
# k config use-context devuser
```

# Generate new kubeconfig only for devuser
```
KUBEAPI_PUBLIC_IP=`k cluster-info | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g' | grep -Eo 'https://.*6443$'`
CA_CERT=`kubectl --kubeconfig=config config view --raw -o=go-template='{{range .clusters}}{{index .cluster "certificate-authority-data"}}{{ end }}'`

cat <<EOF> config.dev
apiVersion: v1
kind: Config

clusters:
- cluster:
    server: $KUBEAPI_PUBLIC_IP
    certificate-authority-data: $CA_CERT
  name: dev

contexts:
- context:
    cluster: dev
    user: devuser
  name: devuser

users:
- name: devuser
  user:
    client-certificate-data: $(cat devuser.crt | base64 | tr -d "\n")
    client-key-data: $(cat devuser.key | base64 | tr -d "\n")


current-context: devuser
EOF
```
