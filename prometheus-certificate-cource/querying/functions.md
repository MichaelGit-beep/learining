# [Funcitons](https://prometheus.io/docs/prometheus/latest/querying/functions/#functions)

## rate(v range-vector)
Rate takes all the datapoints value for range vector, substract first one from the last one, then divide it by time range
```go
http_total_requests_total[1m]

> http_total_requests_total{instance="172.29.29.83:9877", job="webapp"}
< 1308 @1675520355.789
< 1311 @1675520370.789
< 1314 @1675520385.786
< 1317 @1675520400.786

1317 - 1308 = 9 / 60(60 sec = 1m interval) = 0.15
```
## irate(v range-vector)
irate takes all the datapoints value for range vector, it substract the one before last from the last datapoint and devide it by scrape interval
```go
http_total_requests_total[1m]

> http_total_requests_total{instance="172.29.29.83:9877", job="webapp"}
< 1308 @1675520355.789
< 1311 @1675520370.789
< 1314 @1675520385.786
< 1317 @1675520400.786

1317 - 1314 = 3 / 15(time interval between the last and one before last datapoints) = 0.2
```

# [Subqueries](https://prometheus.io/blog/2019/01/28/subquery-support/)

When you want to combine between the functions, but one of the function returns not proper data type expected by the function, you can use subquery to grab range vector from instant vector
```python
rate(v range-vector) returns scalar
max_over_time(v range-vector) 

rate(http_requests[1m]) [2m:15s] return range-vector for last 2 min interval with 15s step
max_over_time(rate(http_requests[1m]) [2m:15s]) - Valid query
```

1. Recieve the rate for last min of transmitted bytes 
```
rate(node_network_transmit_bytes_total{device="ens160"}[1m]) 
> 205
```
2. Recieve the range-vector for last 5 hours with 15 sec step of rates of transmitted bytes for one min
```
rate(node_network_transmit_bytes_total{device="ens160"}[1m]) [5h:15s]

>	228.71111111111108 @1675504425
> 244.1170588627425 @1675504440
> 213.67464391262806 @1675504455
> 244.3940707158255 @1675504470
> 212.63639798208771 @1675504485
> 242.81618774584973 @1675504500
...
```

3. Get the maximum from 1m rate of the transmitted bytes for last 5 hours with 15 sec interval
```
max_over_time(rate(node_network_transmit_bytes_total{device="ens160"}[1m]) [5h:15s])
```