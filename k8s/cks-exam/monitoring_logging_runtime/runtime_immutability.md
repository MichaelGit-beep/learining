# Immutability in k8s - readlOnlyFileSystem and non-privileged user
1. It is possible to add securityContext to pod, that rootfilesystem is read only.
It can brake app since it is required permissions to write, derectories required by app to be writebla should be mounted from volumes, for example emptyDir: {} 
```
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: triton
  name: triton
spec:
  volumes:
  - name: log-volume
    emptyDir: {}
  containers:
  - image: httpd
    imagePullPolicy: Always
    name: triton
    resources: {}
    securityContext:
      readOnlyRootFilesystem: true
    volumeMounts:
    - name: log-volume
      mountPath: /usr/local/apache2/logs
```