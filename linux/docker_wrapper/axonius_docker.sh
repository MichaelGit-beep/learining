#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/axonius/bin:/axonius/bin:/axonius/bin
dockerd --exec-root /axonius/docker --pidfile /axonius/docker/run/docker.pid --config-file /axonius/docker/daemon.json