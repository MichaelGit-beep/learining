#!/bin/bash
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
setenforce 0 && getenforce && sestatus

wget wget https://download.docker.com/linux/static/stable/x86_64/docker-24.0.2.tgz
tar xzvf docker-24.0.2.tgz
mkdir -p /axonius/{docker,bin}
mv docker/* /axonius/bin

cat <<"EOF" > /axonius/bin/axonius_docker
#!/bin/bash
export PATH=$PATH:/axonius/bin
dockerd --exec-root /axonius/docker \
--pidfile /axonius/docker/run/docker.pid \
--config-file /axonius/docker/daemon.json
EOF

chmod +x /axonius/bin/axonius_docker

cat <<EOF > /axonius/docker/daemon.json
{
  "hosts": [
    "unix:///axonius/docker/run/docker.sock"
  ]
}
EOF

cat <<EOF > /lib/systemd/system/axdocker.service
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com

[Service]
ExecStart=/axonius/bin/axonius_docker
ExecReload=/bin/kill -s HUP $MAINPID
TimeoutSec=0
RestartSec=2
Restart=always
StartLimitBurst=3
StartLimitInterval=60s
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
Delegate=yes
Type=notify
NotifyAccess=all
KillMode=mixed
[Install]
WantedBy=default.target
EOF

systemctl daemon-reload
systemctl --now enable axdocker

echo 'export DOCKER_HOST="unix:///axonius/docker/run/docker.sock"' >> .bash_profile && . .bash_profile
echo 'export PATH=$PATH:/axonius/bin' >> .bash_profile && . .bash_profile

