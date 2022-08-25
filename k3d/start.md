# k3d 
Tool that run k3s nodes inside docker containers

It deploys loadbalancer as well

It creates kubeconfig and merge it to your exising kubeconfig ~/.kube/config


## Installation 
```
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

## Minimal Cluster creation
- create minimal cluster - 1 controll-plane and 1 worker node, and ingress with loadbalancer port bounded to local port 80
```
k3d cluster create --port '80:80@loadbalancer'
```
- list clusters 
```
k3d cluster list
```
## Get kubeconfig
```
Manage kubeconfig(s)

Usage:
  k3d kubeconfig [flags]
  k3d kubeconfig [command]

Available Commands:
  get         Print kubeconfig(s) from cluster(s).
  merge       Write/Merge kubeconfig(s) from cluster(s) into new or existing kubeconfig/file.

Flags:
  -h, --help   help for kubeconfig

Global Flags:
      --timestamps   Enable Log timestamps
      --trace        Enable super verbose output (trace logging)
      --verbose      Enable verbose output (debug logging)


```
- Get kubeconfig for specific cluster
```
$ k3d kubeconfig get k3s-default
```
## Multi node cluster creation
- Create cluster named mycluster with 3 masters, and 2 workers, with loadbalancer for ingress and bind local machine port 80 to loadbalancer port 80
```
k3d cluster create mycluster --api-port 127.0.0.1:6445 --servers 3 --agents 2  --port '80:80@loadbalancer'
```




# Requirements
- docker to be able to use k3d at all
- kubectl to interact with the Kubernetes cluster