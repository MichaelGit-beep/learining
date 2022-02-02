# 1. On your client, run
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
````
# 2. Create admin user
```
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
EOF
```

# 3. Give cluster admin role to admin user
```
cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF
```

# 4. Get bearer token
```
kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token
```

# 5. Change kubernetes-dashboard service in kubernetes-dashboard to type NodePort 
```
kubectl edit svc -n kubernetes-dashboard kubernetes-dashboard
```

# 6. Get the node port of service and access the web with HOSTIP:NODEPORT, use admin token from #4 
```
kubectl get svc -n kubernetes-dashboard | grep kubernetes-dashboard

```