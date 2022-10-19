
# Observation command
## Display nodes 
```
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl get nodes 
```
## Display BC pods
```
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods -n briefcam 
```
## !
```
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl get svc -n 
kubernetes-dashboard
```