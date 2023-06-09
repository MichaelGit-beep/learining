#!/bin/bash

wget wget https://download.docker.com/linux/static/stable/x86_64/docker-24.0.2.tgz
tar xzvf docker-24.0.2.tgz
mv docker/* /usr/bin
mkdir -p /axonius/docker
cat <<EOF > /axonius/docker/daemon.json
{
  "hosts": [
    "unix:///axonius/docker/run/docker.sock"
  ]
}
EOF
echo 'export DOCKER_HOST="unix:///axonius/docker/run/docker.sock"' >> ~/.bashrc && . ~/.bashrc
dockerd --exec-root /axonius/docker \
--pidfile /axonius/docker/run/docker.pid \
--config-file /axonius/docker/daemon.json &