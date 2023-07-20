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

yumdownloader --obsoletes --downloadonly --allowerasing -y --resolve  docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
for i in `ls`; do
    packages=$(repoquery --requires --resolve $i 2> /dev/null | grep -Ev '^$' | grep -Ev 'Unable|Mana|ser')
    for i in  $packages; do 
        echo $i
        yumdownloader --obsoletes --downloadonly --allowerasing -y --resolve $i ||: 
    done
done
