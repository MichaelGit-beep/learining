#!/bin/bash
cat <<EOF | sudo sh -x

dnf install -y iptables
modprobe ip_tables
EOF

# echo "root:100000:65536" >> /etc/subuid
# echo "root:100000:65536" >> /etc/subgid
usermod --add-subuids 100000-165535 --add-subgids 100000-165535 root

cat <<EOF>> ~/.bashrc
export XDG_RUNTIME_DIR=/axonius/.docker/run
export PATH=/axonius/bin:$PATH
export DOCKER_HOST=unix:///axonius/.docker/run/docker.sock
EOF

mkdir /axonius