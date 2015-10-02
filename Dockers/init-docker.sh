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

docker inspect ${W2L_INSTANCE_NAME}-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing ${W2L_INSTANCE_NAME}-websrv docker"
 exit 1
fi

if [[ "$W2L_INIT_DB" == "" ]] ; then
 W2L_INIT_DB=0
fi

if [[ "$W2L_INIT_DB" == "1" ]] ; then
 docker exec -ti ${W2L_INSTANCE_NAME}-websrv /var/www/WikiToLearn/init-docker.sh --init-db
else
 docker exec -ti ${W2L_INSTANCE_NAME}-websrv /var/www/WikiToLearn/init-docker.sh
fi
