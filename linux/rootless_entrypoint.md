1. setenforce 0, /etc/selinux
2. rootless_prereq.sh
3. rootless-docker-with-root.sh
4. docker.service, daemon-reload
5. rootless-docker-with-root.sh
6. axonius_rootless_wrapper.sh
7. /axonius/bin/axonius_docker.sh && chmod +x /axonius/bin/axonius_docker.sh
8. mkdir -p /axonius/.config/docker && touch  /axonius/.config/docker/daemon.json
9. systemctl enable --now docker.service