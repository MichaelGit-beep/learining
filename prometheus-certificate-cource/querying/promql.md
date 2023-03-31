# [PromQL](https://prometheus.io/docs/prometheus/latest/querying/basics/)

# [Prometheus Data Types](https://prometheus.io/docs/prometheus/latest/querying/basics/#expression-language-data-types)
# [Prometheus Metrics Type](https://prometheus.io/docs/concepts/metric_types/)
# [Operators](https://prometheus.io/docs/prometheus/latest/querying/operators/) 

#  [Vector Matching](https://prometheus.io/docs/prometheus/latest/querying/operators/#vector-matching)

To match two vectors they should have the same labels.
- Good
```
node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{mountpoint="/"} 
```
- Bad
```
node_filesystem_avail_bytes{mountpoint="/"} / node_filesystem_size_bytes{instance="host1"} 
```
- If no labels are provided Query will use vectors with the same labels by default. But all the labels must be identical on both vectors, otherwise result of the query will be empty. 
`This query will work since both vectors have the same labels {device="/dev/sda5", fstype="ext4", instance="172.29.29.83:9 100", job="self_node", mountpoint="/"}`
```
node_filesystem_avail_bytes / node_filesystem_size_bytes
```
## One-to-one 
### `Match two instant vectors with same labels example:`
```
100 - (node_filesystem_avail_bytes / node_filesystem_size_bytes * 100)
```
This query will divide available bytes to total bytes and multiply by 100 to evaluate persantage of free space, this value will be substracted from scalar 100, result of this query will show percentage usage of disk

## Ignoring and on 
### `Match two instant vectors not with same labels using ignoring:`
```
## http_errors{code="500", method="get"} 40
## http_requests{mothod="get"}  400

http_errors{code="500"} / http_requests - Error, http_requests doesn't have "code" label

http_errors{code="500"} / ignoring(code) http_requests  - Will work
```
### `Match two instant vectors not with same labels using on:`

```
## http_errors{code="500", method="get"} 40
## http_requests{mothod="get"}  400

http_errors{code="500"} / http_requests - Error, http_requests doesn't have "code" label

http_errors{code="500"} / on(method) http_requests - Will match the vectors on specified label
```

## Many-To-One
When you try to match vectors, but their occurance value are different it is not possible, without using `group_left, group_right` modifiers
```
## http_requests{method="get", code="500"} 40

## http_errors{method="get", code="500"}  320
## http_errors{method="put", code="500"}  120

http_requests + on(code) http_errors - Will produce an error, despite the fact their labels are match, right vector has multiple occurances

http_requests + on(code) group_right http_errors - Will work
> {method="get", code="500"} 360
> {method="put", code="500"} 160
```

# [Agregation functions](https://prometheus.io/docs/prometheus/latest/querying/functions/)
```
http_errors
> http_errors{code="200", instance="172.29.29.83:9877", job="webapp", method="delete", path="/logs"} 115
> http_errors{code="300", instance="172.29.29.83:9877", job="webapp", method="put", path="/api"} 115
> http_errors{code="500", instance="172.29.29.83:9877", job="webapp", method="get", path="/db"} 115


sum(http_errors)
> 445
```
- Keyword `by` - Agragate based on provided label
```
sum by(code) (http_requests)
> {code="200"} 115
> {code="300"} 115
> {code="500"} 115

sum by(instance, cpu) (node_cpu_seconds_total)
```

- Keyword `without` - Opposite of `by`. Agregate on every label exept specified
```
sum without(code) (http_requests) == sum by(instance, job, method) (http_requests)
> {instance="172.29.29.83:9877", job="webapp", method="delete"} 115
> {instance="172.29.29.83:9877", job="webapp", method="put"} 115
> {instance="172.29.29.83:9877", job="webapp", method="get"} 115
```

sum by(cpu, instance) (node_cpu_seconds_total{mode="user"}) / sum by(cpu, instance) (node_cpu_seconds_total)