1. Which of the following queries can be used to track the total number of seconds cpu has spent in user + system mode for instance loadbalancer:9100?
- To get the total time spent in user+system mode, run the query node_cpu_seconds_total{instance="loadbalancer:9100", mode="user"} + node_cpu_seconds_total{instance="loadbalancer:9100", mode="system"}, but this query will return no results, because the vector on the left will look for a vector on the right of the “+” operation, that matches the same labels. Since the vector on the left has mode="user" and vector on the right has mode="system", there will be no matches. So we have to ignore the mode label by adding an ignoring(mode). The final query will look like as below:
```
node_cpu_seconds_total{instance="loadbalancer:9100", mode="user"} + ignoring(mode) node_cpu_seconds_total{instance="loadbalancer:9100", mode="system"}
```


2. Get the avarage packet size on all instances
```
sum by(instance)(node_network_receive_bytes_total) / sum by(instance)(node_network_receive_packets_total)
```