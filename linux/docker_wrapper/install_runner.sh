#!/bin/bash -ex
set -ex
export PATH=/dd/axonius/bin/python/bin:/dd/axonius/docker/bin/:$PATH
if [[ -n "$1" && $1 == *python* ]]; then
        echo "Using $1 python interpriter to run installation"
        python_interpriter=$1
        shift
        $python_interpriter __main__.py $@
else
        echo "Using $(which python3) python interpriter to run installation"
        python3 __main__.py $@
fi

# bash installer.py -- /dd/axonius/bin/python/bin/python3 --first-time --install-path /dd/axonius
# bash installer.py -- --first-time --install-path /dd/axonius