#!/bin/bash -ex
set -ex

./offline_docker_installation.sh
./offline_python_unpack.sh

source /dd/axonius/docker/docker_env

if [[ -n "$1" && $1 == *python* ]]; then
        echo "Using $1 python interpreter to run installation"
        python_interpreter=$1
        shift
        $python_interpreter __main__.py $@
else
        echo "Using $(which python3) python interpreter to run installation"
        python3 __main__.py $@
fi

# bash installer.py -- /dd/axonius/bin/python/bin/python3 --first-time --install-path /dd/axonius
# bash installer.py -- --first-time --install-path /dd/axonius