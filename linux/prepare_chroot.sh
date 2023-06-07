#!/bin/bash

mkdir /axonius_root
mkdir /axonius_root/{proc,sys,dev,etc,lib64,bin,usr,sbin,tmp}
mount --rbind /dev /axonius_root/dev
mount --rbind /proc /axonius_root/proc
mount --rbind /sys /axonius_root/sys
rpm --root /axonius_root --initdb
cp /etc/resolv.conf /axonius_root/etc/resolv.conf
cp -r /lib64/* /axonius_root/lib64
cp -v /bin/* /axonius_root/bin
cp -rv /usr/* /axonius_root/usr
cp /sbin/ldconfig /axonius_root/sbin
cp -r /etc/dnf/ /axonius_root/dnf
cp -r /etc/yum.repos.d/ /etc/distro.repos.d /axonius_root/etc
cp -r /etc/pki /axonius_root/etc/

sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
mkdir docker_offline
cd docker_offline
sudo repotrack docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
cd -
rpm --root /axonius_root -Uvh --nosignature docker_offline/*.rpm