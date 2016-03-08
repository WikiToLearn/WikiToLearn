#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ ! -f ./instance_config.conf ]] ; then
 echo "Missing ./instance_config.conf file"
 exit 1
fi

. ./instance_config.conf

if [[ "$WTL_INSTANCE_NAME" == "" ]] ; then
 echo "Missing key env variabile WTL_INSTANCE_NAME"
 exit 1
fi

echo "Bringing up "${WTL_INSTANCE_NAME}"..."

docker inspect wikitolearn-haproxy &> /dev/null
if [[ $? -eq 0 ]] ; then
 docker stop wikitolearn-haproxy
 docker rm wikitolearn-haproxy
fi

CERTS_MOUNT=""
if [[ -d certs/ ]] ; then
 CERTS_MOUNT=" -v "$(pwd)"/certs/:/certs/:ro "
fi

docker run -d --name wikitolearn-haproxy --restart=always \
 -p 80:80 \
 -p 443:443 \
 $CERTS_MOUNT \
 --link ${WTL_INSTANCE_NAME}-websrv:websrv \
 --link ${WTL_INSTANCE_NAME}-parsoid:parsoid \
 $WTL_DOCKER_HAPROXY
