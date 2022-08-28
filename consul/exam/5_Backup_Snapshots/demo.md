```
consul kv put app1 val1
consul snapshot save consul.snap
consul kv delete app1
consul snapshot restore consul.snap
consul kv get app1
```