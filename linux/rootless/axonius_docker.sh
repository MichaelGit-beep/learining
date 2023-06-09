#!/bin/bash
[ -d /axonius/.docker/run ] || {
	mkdir -p /axonius/.docker/run
	chmod -R 777 /axonius/.docker/run
}
export XDG_RUNTIME_DIR=/axonius/.docker/run
export HOME=/axonius
export PATH=/axonius/bin:$PATH
export DOCKER_HOST=unix:///axonius/.docker/run/docker.sock
/axonius/bin/dockerd-rootless.sh