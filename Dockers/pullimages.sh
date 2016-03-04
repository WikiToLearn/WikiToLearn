#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

./create_instance_config.sh

if [[ ! -f instance_config.conf ]] ; then
 echo "Missing instance_config.conf"
 exit 1
fi
. ./instance_config.conf

W2L_DOCKER_OCG_USE="$W2L_DOCKER_OCG"

if [[ "$W2L_SKIP_OCG_DOCKER" == "1" ]] ; then
 W2L_DOCKER_OCG_USE=""
fi

for img in $W2L_DOCKER_MEMCACHED $W2L_DOCKER_MYSQL $W2L_DOCKER_OCG_USE $W2L_DOCKER_WEBSRV $W2L_DOCKER_HAPROXY $W2L_DOCKER_PARSOID $W2L_DOCKER_MATHOID ; do
 docker pull $img
 docker inspect $img &> /dev/null
 if [[ $? -ne 0 ]] ; then
  echo "Error downloading the "$img" image, run again the script"
  exit 1
 fi
done
