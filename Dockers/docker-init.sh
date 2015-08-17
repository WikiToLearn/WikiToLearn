#!/bin/bash
if [[ "$INSTANCE_NAME" == "" ]] ; then
 INSTANCE_NAME="wikitolearn"
fi

docker exec -ti ${INSTANCE_NAME}-websrv /var/www/WikiToLearn/init-docker.sh
