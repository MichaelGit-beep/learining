# [Recording Rules](https://prometheus.io/docs/prometheus/latest/configuration/recording_rules/)
You can preconfigure to run prometheus queries periodicly and store the result, to speed up the process of creating dashboards

## Configuration
1. Add `rule_files` directive to prometheus config
```
global:
 evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
rule_files:
- rules.yml
- /etc/prometheus/rules/*.yml
```
2. Create rule file
```
# /etc/prometheus/rules.yml
groups:
  - name: example
    rules:
    - record: all:http_errors:sum
      expr: sum(http_errors)
```
