# Snaphot

https://learn.hashicorp.com/tutorials/consul/backup-and-restore

https://www.consul.io/commands/snapshot

Is atomic point-in-time of the consul state(RAFT)
- Primary backup sollution
- Create a gzipped tar archive with:
    - K/V 
    - Service catalog
    - Prepared Queries
    - Session 
    - ACL
- Leader should take the snapshot, because only leader has the most updated log of cluster state. But it is possible to take snapshot from non-leader in case when leader is not available, or there is no quorum. 
    - Should be used `-stale` flag. 
    - Can take snapshot with not updated information because of RAFT replication.

## Using Consul Snapshot
- Snasphot can be taken with CLI or API. 
- `[Enterprize]` - Consul Snapshot Agent
- Required a valid ACL token to perform

Usefull before upgrade a Consul cluster, or to bootstrap datacenter with the same name. 

### Restoring
- Is disruptive process, also you cannot selectively restore data
- Consul is not design to handle server failure during restoring, server should be stable. 

### Backup
- [CLI](https://www.consul.io/commands/snapshot)

    The `consul snapshot` command:
    - agent(ent)
    - inspect - View metadata about an existing snapshot file
    - restore - restore consul cluster from snapshot file
    - save - creata a new snapshot 

    ```
    consul snapshot save backup.snap
    ```
    Restore 
    ```
    consul snapshot inspect consul.snap
    consul snapshot restore consul.snap
    ```
- [API](https://www.consul.io/api-docs/snapshot) 

Take snapshot
```
curl http://127.0.0.1:8500/v1/snapshot --output snapshot.snap
```


Restore from snapshot
```
curl \
    --request PUT \
    --data-binary @snapshot.snap \
    http://127.0.0.1:8500/v1/snapshot
```

## `Consul snapshot agent(Enterprize)`
Long-running daemon that regularly take snapshots of the Consul cluster
- Retention 
- Scheduling
- Multiple option to store snapshots: Local, S3, GBS, ABS
- Automated Snapshots 
- Manages its own leadership election for HA(not related to Consul cluster leader election)
- Provides failover in the event the snapshot leader becomes unavailable
- Run the agent across all the servers but only get one consistent snapshot per interval
- Registers itself as a Aconsul service
    - Easy to keep track of status and health using API, CLI, UI
    - Health checks can alert you of problem so you can take actions

## Configuring agent
- Create agent config file `/etc/snapshot.d/snapshot.json` retention, interval etc...
- Create systemd unit file `/etc/systemd/system/snapshot.servie`
- start service `systemctl start snapshot`