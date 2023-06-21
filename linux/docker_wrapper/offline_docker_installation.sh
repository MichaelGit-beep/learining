#!/bin/bash -e
set -e
set +x

RED='\033[0;31m'
Yellow='\033[0;33m'
RESET='\033[0m'
GREEN='\033[0;32m'
sec="5 4 3 2 1 0"
install_path=$1

function log_info() {
  echo -e "${Yellow}$1${RESET}"
}

function log_error() {
  echo -e "${RED}$1${RESET}"
}

function log_green() {
  echo -e "${GREEN}$1${RESET}"
}

[ $(id -u) != 0 ] && { 
  log_error "Need to run with sudo priviliges" 
  exit 1 
}

source /etc/os-release
[ $VERSION_ID != "8.6" ] && {
  log_error "This installation was tested on RHEL 8.6 only. Script may not work on your system. Pause for 10 sec"
  sleep 10
}


function prereqs() {
  [ $(getenforce) == "Enforcing" ] && {
    log_error "SElinux is enabled.\nRun the following command to dissable it and rerun the installer:\n\nsetenforce 0 && getenforce && sestatus\nAnd make sure it remain disabled after the restart:\nsed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config"
    exit 1
  }
  # sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
  # setenforce 0 && getenforce && sestatus
  iptables --version || { 
    log_info "Make sure iptables installed and configured and rerun the installer"
    exit 1
  }

  # dnf install iptables
  [ $0 == "docker" ] && {
    log_info "Renaming $0 to -> axonius_docker_installer.sh to avoid conflicts"
    mv -v $0 axonius_docker_installer.sh
  }
  DOCKER_DIR=${install_path:=/dd/axonius/docker}
  tar xzf docker-24.0.2.tgz
}

log_info "prerequisites check"
log_info "extracting docker binaries"
prereqs

log_info "Installing docker to $DOCKER_DIR" && sleep 5
log_info "Creating directory struture if not exist. Perform cleanup if exist"
rm -rf ${DOCKER_DIR}
mkdir -pv ${DOCKER_DIR}/{bin,data,run} 
mv -v docker/* ${DOCKER_DIR}/bin
rm -rf docker

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

log_info "Stopping and masking previous docker installation"
set -x
systemctl stop docker.socket &> /dev/null || :
systemctl disable docker.socket &> /dev/null || :
systemctl mask docker.socket &> /dev/null || :
systemctl stop docker.service &> /dev/null || :
systemctl disable docker.service &> /dev/null || :
set +x

log_info "Creating systemd service for docker /etc/systemd/system/docker.service"
cat <<EOF > /etc/systemd/system/docker.service
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
systemctl --now enable docker


log_green "Installation Completed"
cat << EOF > ${DOCKER_DIR}/docker_readme
[In order to interact with docker need to export this envieronment variables]

export DOCKER_HOST="unix://${DOCKER_DIR}/run/docker.sock"
export PATH=\$PATH:${DOCKER_DIR}/bin

[To persist this configuration need to update ~/.bashrc or ~/.bash_profile]

echo "export DOCKER_HOST="unix://${DOCKER_DIR}/run/docker.sock"" >> ~/.bash_profile && . ~/.bash_profile
echo "export PATH=$PATH:${DOCKER_DIR}/bin" >> ~/.bash_profile && . ~/.bash_profile



[Start and stop docker with systemd]
systemctl stop docker
systemctl start docker


[View docker logs]
journalctl -u docker


[Quickstart]
export DOCKER_HOST="unix://${DOCKER_DIR}/run/docker.sock"
export PATH=\$PATH:${DOCKER_DIR}/bin
docker run hello-world
EOF

cat <<EOF > ${DOCKER_DIR}/docker_env
export DOCKER_HOST="unix://${DOCKER_DIR}/run/docker.sock"
export PATH=\$PATH:${DOCKER_DIR}/bin
EOF

cat ${DOCKER_DIR}/docker_readme
source ${DOCKER_DIR}/docker_env

log_info "Readme could be found in this path: ${DOCKER_DIR}/docker_readme"
log_info "Add docker to PATH for current session: source ${DOCKER_DIR}/docker_env"