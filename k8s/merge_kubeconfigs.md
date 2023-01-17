```
cp ~/.kube/config ~/.kube/config.bak 
KUBECONFIG=~/.kube/config:~/conf kubectl config view --flatten > /tmp/config 
mv /tmp/config ~/.kube/config 
rm ~/.kube/config.bak
```