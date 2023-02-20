# Tool to generate metrics for docker containers
1. Start cadvisor as a container
```
https://github.com/google/cadvisor

VERSION=v0.36.0 # use the latest release version from https://github.com/google/cadvisor/releases
sudo docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:ro \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  --privileged \
  --device=/dev/kmsg \
  gcr.io/cadvisor/cadvisor:$VERSION
```

2. Configure prometheus to scrape metrics from it
```
scrape_configs:
  - job_name: "cadvisor"
    static_configs:
    - targets: ["172.29.29.83:8080"]
```