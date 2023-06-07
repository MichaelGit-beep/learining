1. setenforce 0, /etc/selinux
2. rootless_prereq.sh
3. rootless-docker-with-root.sh
4. docker.service, daemon-reload
5. rootless-docker-with-root.sh
6. axonius_rootless_wrapper.sh
7. mv ~/bin /axonius
8. systemctl start docker.service