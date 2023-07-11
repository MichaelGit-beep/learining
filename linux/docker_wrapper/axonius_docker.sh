#!/bin/bash
export PATH=$PATH:/bb/axonius/docker/bin
dockerd --exec-root /bb/axonius/docker --pidfile /bb/axonius/docker/run/docker.pid --config-file /bb/axonius/docker/daemon.json