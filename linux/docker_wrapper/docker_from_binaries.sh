#!/bin/bash
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
setenforce 0 && getenforce && sestatus
dnf install -y iptables wget vim tmux

wget wget https://download.docker.com/linux/static/stable/x86_64/docker-24.0.2.tgz
tar xzvf docker-24.0.2.tgz
mkdir -p /dd/axonius/docker/{bin,data,run}
mv docker/* /dd/axonius/docker/bin

cat <<"EOF" > /dd/axonius/docker/bin/axonius_docker
#!/bin/bash
export PATH=$PATH:/dd/axonius/docker/bin
dockerd --exec-root /dd/axonius/docker \
--pidfile /dd/axonius/docker/run/docker.pid \
--config-file /dd/axonius/docker/daemon.json
EOF

chmod +x /dd/axonius/docker/bin/axonius_docker

cat <<EOF > /dd/axonius/docker/daemon.json
{
  "hosts": [
    "unix:///dd/axonius/docker/run/docker.sock"
  ],
  "data-root": "/dd/axonius/docker/data"
}
EOF

cat <<EOF > /etc/systemd/system/axdocker.service
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com

[Service]
ExecStart=/dd/axonius/docker/bin/axonius_docker
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

echo 'export DOCKER_HOST="unix:///dd/axonius/docker/run/docker.sock"' >> ~/.bash_profile && . ~/.bash_profile
echo 'export PATH=$PATH:/dd/axonius/docker/bin' >> ~/.bash_profile && . ~/.bash_profile