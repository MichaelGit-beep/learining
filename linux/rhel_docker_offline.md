## Download all the dependencies on machine with the internet

```
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

sudo yum install --downloadonly --downloaddir=docker_offline docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

tar czf docker_offline_$(. /etc/os-release && echo ${ID}_${VERSION_ID}).tgz docker_offline

ls docker_offline_$(. /etc/os-release && echo ${ID}_${VERSION_ID}).tgz
```

## Install offline package
```
tar xzf docker_offline_rhel_9.2.tgz
sudo rpm -Uvh docker_offline/*.rpm
```