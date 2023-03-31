# Promtools
1. check and validate configurations and rules from files
```
$ promtool check config /etc/prometheus/prometheus.yml

Checking /etc/prometheus/prometheus.yml
 SUCCESS: /etc/prometheus/prometheus.yml is valid prometheus config file syntax
```
2. Validate metrics passed to it are correctly formatted
3. can perform queries on a Prometheus server
4. debuggin and profilind a prometheus server
5. perform unit tests against Recording/Alerting rules