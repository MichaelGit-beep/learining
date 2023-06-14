#!/bin/bash -e
set -e

RED='\033[0;31m'
Yellow='\033[0;33m'
RESET='\033[0m'
GREEN='\033[0;32m'
sec="5 4 3 2 1 0"
clear

function log_info() {
  echo -e "${Yellow}$1${RESET}"
}

function log_error() {
  echo -e "${Red}$1${RESET}"
}

function log_green() {
  echo -e "${GREEN}$1${RESET}"
}

[ $(id -u) != 0 ] && { 
  log_error "Need to run with sudo priviliges" 
  exit 1 
}

function prereqs() {
  sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
  setenforce 0 && getenforce && sestatus
  dnf install -y iptables wget vim tmux

  tmp=$(echo `realpath $1 2> /dev/null || :`)
  DOCKER_DIR=${tmp:=/dd/axonius/docker}
  wget wget https://download.docker.com/linux/static/stable/x86_64/docker-24.0.2.tgz && sleep 3
  tar xzf docker-24.0.2.tgz
}

log_info "Dissabling selinux, installing prerequisites, downloading docker"
prereqs &> install_ax_docker.log || {
  cat install_ax_docker.log
  log_error "Failed to install docker"
  exit 1
}

log_info "Installing docker to $DOCKER_DIR" && sleep 3
log_info "Creating directory struture"
mkdir -pv ${DOCKER_DIR}/{bin,data,run} 
mv -v docker/* ${DOCKER_DIR}/bin
rm -rf docker-24.0.2.tgz docker

log_info "Creating docker start entrypoint: ${DOCKER_DIR}/bin/axonius_docker"
cat <<EOF
#!/bin/bash
export PATH=\$PATH:${DOCKER_DIR}/bin
dockerd --exec-root ${DOCKER_DIR} \
--pidfile ${DOCKER_DIR}/run/docker.pid \
--config-file ${DOCKER_DIR}/daemon.json
EOF

cat <<EOF > ${DOCKER_DIR}/bin/axonius_docker
#!/bin/bash
export PATH=\$PATH:${DOCKER_DIR}/bin
dockerd --exec-root ${DOCKER_DIR} \
--pidfile ${DOCKER_DIR}/run/docker.pid \
--config-file ${DOCKER_DIR}/daemon.json
EOF

chmod +x ${DOCKER_DIR}/bin/axonius_docker

log_info "Creating custom docker confing ${DOCKER_DIR}/daemon.json"
cat <<EOF 
{
  "hosts": [
    "unix://${DOCKER_DIR}/run/docker.sock"
  ],
  "data-root": "${DOCKER_DIR}/data"
}
EOF
cat <<EOF > ${DOCKER_DIR}/daemon.json
{
  "hosts": [
    "unix://${DOCKER_DIR}/run/docker.sock"
  ],
  "data-root": "${DOCKER_DIR}/data"
}
EOF

log_info "Creating systemd service for docker /etc/systemd/system/axdocker.service"
cat <<EOF > /etc/systemd/system/axdocker.service
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com

[Service]
ExecStart=${DOCKER_DIR}/bin/axonius_docker
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


log_green "Installation Completed"
cat << EOF
[In order to interact with docker need to export this envieronment variables]

export DOCKER_HOST="unix://${DOCKER_DIR}/run/docker.sock
export PATH=$PATH:${DOCKER_DIR}/bin

[To persist this configuration need to update ~/.bashrc or ~/.bash_profile]

echo "export DOCKER_HOST="unix://${DOCKER_DIR}/run/docker.sock"" >> ~/.bash_profile && . ~/.bash_profile
echo "export PATH=$PATH:${DOCKER_DIR}/bin" >> ~/.bash_profile && . ~/.bash_profile



[Start and stop docker with systemd]
systemctl stop axdocker
systemctl start axdocker


[View docker logs]
journalctl -u axdocker


[Quickstart]
export DOCKER_HOST="unix://${DOCKER_DIR}/run/docker.sock"
export PATH=\$PATH:${DOCKER_DIR}/bin
docker run hello-world
EOF
