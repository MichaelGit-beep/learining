# [PodSecurityPolicy](https://kubernetes.io/docs/concepts/security/pod-security-policy/) 
 
 ClusterScoped Resource difines behaviour of dissabled by defaul Mutating Admission Controller - `PodSecurityPolicy`, it can be enabled by passing parameter to kube-apiserver start command


## To start using podsercurity policy you need to:
1. Enable PodSecurityPolicy admission plugin. By editing kube-api manifest.
```
--enable-admission-plugins=PodSecurityPolicy
```
2. By default access to sercurity policy is restricted, so need to create a CLusterRole that will allow access to securiry policies objects:
```
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: <role name>
rules:
- apiGroups: ['policy']
  resources: ['podsecuritypolicies']
  verbs:     ['use']
EOF
```
3. Bind default service account to this ClusterRole. Edit Namespace in a manifest file  <<authorized namespace>>
```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: <binding name>
roleRef:
  kind: ClusterRole
  name: <role name>
  apiGroup: rbac.authorization.k8s.io
subjects:
# Authorize all service accounts in a namespace (recommended):
- kind: Group
  apiGroup: rbac.authorization.k8s.io
  name: system:serviceaccounts:<authorized namespace>

```
4. Create PodSecurityPolicy object. This policy will prevent from creat pods with `privileged: true` securityContext
```
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: example
spec:
  privileged: false  # Don't allow privileged pods!
  # The rest fills in some required fields.
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  runAsUser:
    rule: RunAsAny
  fsGroup:
    rule: RunAsAny
  volumes:
  - '*'
```