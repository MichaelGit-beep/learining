>## Service without selector - to forward traffic to external resources or DNS name 
1. Manually create service and endpoint. If Service port has a name, then EP port name must also own the same name
```
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: NodePort
  ports:
    - name: tcp
      protocol: TCP
      port: 9090
      targetPort: 9090
    - name: udp
      protocol: TCP
      port: 3000
      targetPort: 3000

---
apiVersion: v1
kind: Endpoints
metadata:
  name: my-service
subsets:
  - addresses:
      - ip: 10.0.0.154
    ports:
     - name: tcp
       port: 9000
     - name: udp
       port: 3000
```
2. Checkup
```
root@rhel:~# kubectl describe service my-service
Name:                     my-service
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 <none>
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.107.226.157
IPs:                      10.107.226.157
Port:                     tcp  9090/TCP
TargetPort:               9090/TCP
NodePort:                 tcp  30260/TCP
Endpoints:                10.0.0.154:9000
Port:                     udp  3000/TCP
TargetPort:               3000/TCP
NodePort:                 udp  32406/TCP
Endpoints:                10.0.0.154:3000
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>



root@rhel:~# kubectl describe ep my-service
Name:         my-service
Namespace:    default
Labels:       <none>
Annotations:  <none>
Subsets:
  Addresses:          10.0.0.154
  NotReadyAddresses:  <none>
  Ports:
    Name  Port  Protocol
    ----  ----  --------
    tcp   9000  TCP
    udp   3000  TCP

Events:  <none>

```