## Run this on the first server
```
curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET INSTALL_K3S_EXEC="server --cluster-init" sh -
```
## Run this on the other two servers, one at a time
```
curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET K3S_URL=https://172.30.30.230:6443 INSTALL_K3S_EXEC="server" sh -
```


## Join worker node - use token from /var/lib/rancher/k3s/server/node-token om master if master was initiated without K3S_TOKEN
```
curl -sfL https://get.k3s.io | K3S_URL=https://172.30.30.230:6443 INSTALL_K3S_EXEC=agent K3S_TOKEN=SECRET sh - 
```


uninstall script bash /usr/local/bin/k3s-agent-uninstall.sh

uninstall script bash /usr/local/bin/k3s-uninstall.sh