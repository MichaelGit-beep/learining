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
```
- Option 1: donwload using yum install
```
mkdir docker_offline

sudo yum install --downloadonly --downloaddir=docker_offline docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```
- Option 2(Prefferable): using repotrack
```
mkdir docker_offline
cd docker_offline
sudo repotrack docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
cd -
```
## Create archive with all the dependencies
```
tar czf docker_offline_$(. /etc/os-release && echo ${ID}_${VERSION_ID}).tgz docker_offline

ls docker_offline_$(. /etc/os-release && echo ${ID}_${VERSION_ID}).tgz
```

## Install offline package
```
tar xzf docker_offline_rhel_9.2.tgz
sudo rpm -Uvh --replacepkgs --oldpackage --nosignature docker_offline/*.rpm
###!!! In Case you will have conflicts of installed package with the same package that is already installed. 
### Run yum remove <conflicted package name>
### Exapmle: 
## error: Failed dependencies:
## 	containerd conflicts with containerd.io-1.6.21-3.1.el8.x86_64
## 	containerd conflicts with (installed) containerd.io-1.6.21-3.1.el8.x86_64
# Sollution yum remove containerd and rerun sudo rpm -Uvh --replacepkgs --oldpackage --nosignature docker_offline/*.rpm

sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER
sudo su - $USER
docker info | grep -i root
```