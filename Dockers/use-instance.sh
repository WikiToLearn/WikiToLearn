#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ ! -f ./instance_config.conf ]] ; then
 echo "Missing ./instance_config.conf file"
 exit 1
fi

. ./instance_config.conf

if [[ "$W2L_INSTANCE_NAME" == "" ]] ; then
 echo "Missing key env variabile W2L_INSTANCE_NAME"
 exit 1
fi

echo "Bringing up "${W2L_INSTALNCE_NAME}"..."

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
 -p 8000:8000 \
 $CERTS_MOUNT \
 --link ${W2L_INSTANCE_NAME}-websrv:websrv \
 --link ${W2L_INSTANCE_NAME}-ocg:ocg \
 $W2L_DOCKER_HAPROXY
