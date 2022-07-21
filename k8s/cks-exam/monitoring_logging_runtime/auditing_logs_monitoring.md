# K8S events

Every Request sended to kube-apiserver has a different stages, that represent an event that could be logged

Logging is dissabled by default. 

1. RequestRecieved - On this stage request is authenticated, authorized and if it valid it continue to the second stage
2. ResponseStarted - On this stage generates a response body, when it send it became third stage where `ResponseCompleted` or `Panic` - in case that some thing was wrong

## Configre audit loggin in k8s
It is achived by built-in object - `Policy`

1. Enable k8s logging, by adding `--audit-log-path=/path/to/save/log` to kube-apiserver
> It is possible to configure two types of backend: to file, or webhook to send logs to Falco, for example
2. Create Policy definition file and pass it ass a parameter to kube-apiserver `--audit-policy-file=/etc/kubernetes/audit-policy.yaml`

### Rotation of audit logs
3. `--audit-log-maxage=<int>` - Specify what is the maximum days to log into single file
4. `--audit-log-maxbackup=5` - Configuration of how much logfiles to keep
5. `--audit-log=maxsize=100` - Size in megabytes for maximum size of audit-log before rotate

# Demo 
1. Create Policy with the rules 
```
cat <<EOF> /etc/kubernetes/prod-audit.yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata
  verbs: ["delete"]
  resources:
  - group: ""
    resources: ["secrets"]
EOF
```
2. Edit kube-api manifest
```
vim /etc/kubernetes/manifests/kube-apiserver.yaml

startup options

 - --audit-policy-file=/etc/kubernetes/prod-audit.yaml
 - --audit-log-path=/var/log/prod-secrets.log
 - --audit-log-maxage=30


 Add volumes: 

  - name: audit
    hostPath:
      path: /etc/kubernetes/prod-audit.yaml
      type: File

  - name: audit-log
    hostPath:
      path: /var/log/prod-secrets.log
      type: FileOrCreate

MountVolumes


  - mountPath: /etc/kubernetes/prod-audit.yaml
    name: audit
    readOnly: true
  - mountPath: /var/log/prod-secrets.log
    name: audit-log
    readOnly: false
```
> Wait untill kube-apiserver pod is recreated by kubelet as it static pod
3. Create secret and delete it. Log will be created on master node only
```
kubectl create secret generic --from-literal=abc=123 somesecret
kubectl delete secrets somesecret
cat /var/log/prod-secrets.log | grep somesecret
```