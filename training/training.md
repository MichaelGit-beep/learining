
# Observation command
Should be implemented from the master node, unless you copy kubeconfig and install kubectl on any other machine(can be windows)

`Setup kubectl`
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# or

kubectl get pods --kubeconfig=/etc/kubernetes/admin.conf

# or:
KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods

# Setup bash completion
source <(kubectl completion bash) 
echo "source <(kubectl completion bash)" >> ~/.bashrc 

# Configure alias k -> kubectl
alias k=kubectl
complete -o default -F __start_kubectl k
```
## Display nodes 
```
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl get nodes 
```
## Display BC pods
```
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods -n briefcam 
```

## Pring NG Logs
```
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods -n briefcam | grep ng-
> ng-teslap4-bc-osx6-1673958026-77575b5cb6-4lcnk   1/1     Running   0          3m29s

sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl logs -n briefcam ng-teslap4-bc-osx6-1673958026-77575b5cb6-4lcnk
>
```
## Check NG Settings
```
sudo KUBECONFIG=/etc/kubernetes/admin.conf  kubectl get cm -n briefcam | grep bc-configs-ng 
sudo KUBECONFIG=/etc/kubernetes/admin.conf  kubectl get cm -n briefcam -o yaml bc-configs-ng-teslap4-bc-osx6-1673958026
```


## Get Dashboard Service
```
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl get svc -n 
kubernetes-dashboard
```

## Print dashboard token to access dashboard on :31000
```
sudo KUBECONFIG=/etc/kubernetes/admin.conf kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token | sed -e 's/token:\s*//'
```



# Windows side
### Port validator
```powershell
# taskkill /f /im nginx.exe

get-process -id (Get-NetTCPConnection -localport 1120).OwningProcess  # VMS agent internal
# get-process -id (Get-NetTCPConnection -localport 5002).OwningProcess  # OX6 ProcessingGW internal
get-process -id (Get-NetTCPConnection -localport 1883).OwningProcess  # mosquito 
get-process -id (Get-NetTCPConnection -localport 5672).OwningProcess  # rabbit
get-process -id (Get-NetTCPConnection -localport 49149).OwningProcess # New OX6 ProcessingGW
get-process -id (Get-NetTCPConnection -localport 49151).OwningProcess # VMS Agent 
```