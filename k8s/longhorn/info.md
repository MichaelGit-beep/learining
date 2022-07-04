## Prereqiusites 
- https://longhorn.io/docs/1.2.2/deploy/install/ 
## Installation with Helm
- https://longhorn.io/docs/1.2.2/deploy/install/install-with-helm/
## Access to the WEB-UI 
- Change longhorn-frontend service to node port or configure ingress
```
$ redhat@controllplane1:~$ kubectl get svc -n longhorn-system | grep longhorn-frontend
longhorn-frontend   ClusterIP   10.98.139.194    <none>        80/TCP      46h

```
## How to use
- Will be created storage class named longhorn
- Create PVC. spec.storageClassName need to be specified only if longhorn storageclass is not default
cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dynamic-test
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: longhorn
  resources:
    requests:
      storage: 3Gi
---
# - Attach this PVC the pod
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: testpod
  name: testpod
spec:
  volumes:
  - name: test
    persistentVolumeClaim:
      claimName: dynamic-test
  containers:
  - image: nginx
    name: testpod
    volumeMounts:
    - mountPath: "/mount"
      name: test
EOF

## Creating snapshot
- Click on the name of created volume that is in attached state in longhorn console
- In snapshot and backup section slick "volume head" and then snaphot
## Restore from snapshot
- Kill the pod which use this PV
- Detach volume in Longhorn console 
- Attach this volume to the node in maintenance mode
- Click on desired snapshot and chose "Revert"
- Detach this volume from the node
- Create the pod again
## Automatic snapshot creation 
- In the volume properties it is possible to set replicas count and create a cronjob to take a snaphots by scheduling, with retention period

