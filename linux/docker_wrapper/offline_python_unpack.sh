#!/bin/bash
set -e
Yellow='\033[0;33m'
RESET='\033[0m'
GREEN='\033[0;32m'

function log_info() {
  echo -e "${Yellow}$1${RESET}"
}

function log_green() {
  echo -e "${GREEN}$1${RESET}"
}

log_info "Performing clenup of /dd/axonius/bin/python"
rm -rf /dd/axonius/bin/python
mkdir -pv /dd/axonius/bin/
log_info "Moving Python 3.8.10 amd64 to /dd/axonius/bin/python"
cp -rv python /dd/axonius/bin/
log_green "Done"