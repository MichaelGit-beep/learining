#!/bin/bash
DOCKER_START_LINE=$(($(sed -n '/^__DOCKER_STARTS__/{=;q;}' "$0")+1))
DOCKER_END_LINE=$(($(sed -n '/^__DOCKER_ENDS__/{=;q;}' "$0")-1))
sed -n ${DOCKER_START_LINE},${DOCKER_END_LINE}p $0
exit 1
__DOCKER_STARTS__
123
123
__DOCKER_ENDS__