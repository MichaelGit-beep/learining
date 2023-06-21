#!/bin/bash
set -e
set +x

Yellow='\033[0;33m'
RESET='\033[0m'
GREEN='\033[0;32m'
install_path=$1

function log_info() {
  echo -e "${Yellow}$1${RESET}"
}

function log_green() {
  echo -e "${GREEN}$1${RESET}"
}

PYTHON_DIR=${install_path:=/dd/axonius/bin}
log_info "Performing clenup of $PYTHON_DIR/python"
rm -rf $PYTHON_DIR/python
mkdir -pv $PYTHON_DIR/
log_info "Moving Python 3.8.10 amd64 to $PYTHON_DIR/python"
cp -r python $PYTHON_DIR/
log_green "Done"

export PATH=$PYTHON_DIR/python/bin:$PATH