#!/bin/bash 
set -xe
[ -z $1 ] && { echo "Provide swapfile size as G as a first arg"; exit 1; }
[ -z $2 ] && { echo "Provide absolute path to desired swap file location as a second arg"; exit 1; }

fallocate -l ${1}G $2
chmod 600 $2
mkswap $2
swapon $2
echo "$2 swap swap defaults 0 0" >> /etc/fstab