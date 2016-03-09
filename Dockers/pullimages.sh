#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

./create_instance_config.sh

if [[ ! -f instance_config.conf ]] ; then
 echo "Missing instance_config.conf"
 exit 1
fi
. ./instance_config.conf

WTL_DOCKER_OCG_USE="$WTL_DOCKER_OCG"

if [[ "$WTL_SKIP_OCG_DOCKER" == "1" ]] ; then
 WTL_DOCKER_OCG_USE=""
fi

for img in $WTL_DOCKER_MEMCACHED $WTL_DOCKER_MYSQL $WTL_DOCKER_OCG_USE $WTL_DOCKER_WEBSRV $WTL_DOCKER_HAPROXY $WTL_DOCKER_PARSOID $WTL_DOCKER_MATHOID ; do
 docker pull $img
 docker inspect $img &> /dev/null
 if [[ $? -ne 0 ]] ; then
  echo "Error downloading the "$img" image, run again the script"
  exit 1
 fi
done
