#!/bin/bash -ex
set -ex

export PATH=/dd/axonius/bin/python/bin:/dd/axonius/docker/bin/:$PATH
export DOCKER_HOST=unix:///dd/axonius/docker/run/docker.sock

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