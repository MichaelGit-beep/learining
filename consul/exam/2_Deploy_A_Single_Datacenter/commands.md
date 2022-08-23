```
consul agent \ 
    -server \
    -bootstrap-expect=1 \
    -node=agent-one \
    -bind=10.0.0.82 \
    -data-dir=/tmp/consul \
    -config-dir=/etc/consul.d 

consul members

consul operator raft list-peers
```