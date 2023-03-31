1. Install kind
2. Create kustomization file to deploy awx operator and awx resource
```
cat <<EOF> awx.yaml
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx-demo
spec:
  service_type: nodeport
  nodeport_port: 30000
EOF
```
```
cat <<EOF> kustomization.yml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  # Find the latest tag here: https://github.com/ansible/awx-operator/releases
  - github.com/ansible/awx-operator/config/default?ref=1.4.0
  - awx.yaml

images:
  - name: quay.io/ansible/awx-operator
    newTag: 1.4.0

# Specify a custom namespace in which to install AWX
namespace: awx
EOF
```
3. Access WEB UI via nodeport
```
k3snodei:30000
```
4. user `admin` password `6ABQTDSkuszltVNs1UY7WH6tERyZIMaT`
```
$ kubectl get secret awx-demo-admin-password -o yaml -n awx | grep -w password: | awk '{print $2}' | base64 -d; echo

output: 6ABQTDSkuszltVNs1UY7WH6tERyZIMaT
```
