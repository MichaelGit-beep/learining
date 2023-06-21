#!/bin/bash -ex
set -ex

first_time=false
axonius_dir=""
args=$@

while (($#)); do
        case $1 in
                --first-time)
                first_time=true
                ;;
                --install-path)
                shift
                axonius_dir=$1
                echo "Creating directory structure $axonius_dir" 
                mkdir -p $axonius_dir || {
                        echo "Make sure $axonius_dir" is a valid path and rerun the installer
                        exit
                }
                ;;
        esac
        shift
done

if [[ $first_time != true || -z $axonius_dir ]]; then
        echo "Expected arguments --first-time --install-path /path wasn't provided"
        exit 1
fi

. ./offline_docker_installation.sh $axonius_dir/docker
. ./offline_python_unpack.sh $axonius_dir/bin


echo "Using $(which python3) python interpreter to run installation with - $args - arguments"
python3 __main__.py $args


# bash installer.py -- --first-time --install-path /dd/axonius