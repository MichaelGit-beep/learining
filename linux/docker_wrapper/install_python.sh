#!/bin/bash
dnf install -y zlib zlib-devel make gcc
wget https://www.python.org/ftp/python/3.8.10/Python-3.8.10.tgz
tar xzf Python-3.8.10.tgz
cd Python-3.8.10

mkdir -pv /dd/axonius/bin/python
./configure --prefix=/dd/axonius/bin/python 
make
make install
echo done