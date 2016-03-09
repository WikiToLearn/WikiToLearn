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

docker inspect ${WTL_INSTANCE_NAME}-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing ${WTL_INSTANCE_NAME}-websrv docker"
 exit 1
fi
docker exec ${WTL_INSTANCE_NAME}-websrv chown www-data:www-data /var/www/ -R

if [[ "$WTL_INIT_DB" == "" ]] ; then
 WTL_INIT_DB=0
fi

if [[ "$WTL_INIT_DB" == "1" ]] ; then
 docker exec -ti ${WTL_INSTANCE_NAME}-websrv su -c sh -c "/var/www/WikiToLearn/init-docker.sh --init-db" -s /bin/bash www-data
else
 docker exec -ti ${WTL_INSTANCE_NAME}-websrv su -c sh -c "/var/www/WikiToLearn/init-docker.sh" -s /bin/bash www-data
fi
