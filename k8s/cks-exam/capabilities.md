Capabilities - are permissions to perform action that usually requires root access. 
They grouped by tasks that could be deligated to the processes that are not intended to run as root user, but still need to perform oprations that need root rights. 

- Check capabilities used by the binary
```
getcap /usr/bin/ping
```
- check capabilities of the process
```
ps aux | grep /usr/sbin/sshd | grep -v grep

getpcaps PID
```

Run pod with capabilities, and drop some of them:
```
apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-4
spec:
  containers:
  - name: sec-ctx-4
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]
        drop: ["CHOWN]
```
