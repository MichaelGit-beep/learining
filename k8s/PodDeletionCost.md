# Features allow to set annotation with pod deletion cost, pod with the lowest cost will be deleted while deployment scale down, default value=0

## **Enable feature**

>Using the sudo command, edit the following YAML files:

>/etc/kubernetes/manifests/kube-apiserver.yaml
>
>/etc/kubernetes/manifests/kube-controller-manager.yaml
>
>/etc/kubernetes/manifests/kube-scheduler.yaml
>
### To each file add a string as a running option. After it reboot all k8s components
> \-   --feature-gates=PodDeletionCost=true 
```
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 10.0.0.146:6443
  creationTimestamp: null
  labels:
    component: kube-apiserver
    tier: control-plane
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --advertise-address=10.0.0.146
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --feature-gates=PodDeletionCost=true
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
```
### Verify changes 
```
# kubectl describe pods -n kube-system kube-apiserver-rhel | grepfeature
      --feature-gates=PodDeletionCost=true

# kubectl describe pods -n kube-system kube-controller-manager-rhel | grep feature
      --feature-gates=PodDeletionCost=true

# kubectl describe pods -n kube-system kube-scheduler-rhel | grep feature
      --feature-gates=PodDeletionCost=true

```

## Assign PodDeletionCost annotation to the pods
```
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: web1
  name: web1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web1
  template:
    metadata:
      annotations:
        controller.kubernetes.io/pod-deletion-cost: "10"
      labels:
        app: web1
    spec:
      containers:
      - image: httpd
        name: httpd

```

> ## After configuration while performing scale down, the pod with the lowest PodDeletionCost will be deleted.
```
kubectl scale deployment web1 --replicas=2

```
