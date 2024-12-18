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

docker_pkg="docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
yumdownloader --obsoletes --downloadonly --allowerasing -y --resolve $docker_pkg
rm -f docker_deps.txt
for docker_dep in $docker_pkg; do
    echo "processing $docker_dep"
    deps=`yum -q deplist $docker_dep | grep provider | sed 's/.*provider: //g' | uniq`
    for i in $deps; do echo $i >> docker_deps.txt; done
done
all_pkg=`cat docker_deps.txt | sort -u`
echo "Downloading `cat docker_deps.txt | sort -u | wc -l` packages"
yumdownloader --obsoletes --downloadonly --allowerasing -y --resolve $all_pkg


sudo rpm -Uvh --replacepkgs --oldpackage --nosignature *.rpm