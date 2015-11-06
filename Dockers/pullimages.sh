#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

./create_instance_config.sh

if [[ ! -f instance_config.conf ]] ; then
 echo "Missing instance_config.conf"
 exit 1
fi
. ./instance_config.conf

for img in $W2L_DOCKER_MEMCACHED $W2L_DOCKER_MYSQL $W2L_DOCKER_OCG $W2L_DOCKER_WEBSRV $W2L_DOCKER_HAPROXY ; do
 docker pull $img
done
