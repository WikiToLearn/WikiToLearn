#!/bin/bash

cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ -f instance_name.conf ]] ; then
 . ./instance_name.conf
fi

if [[ "$INSTANCE_NAME" == "" ]] ; then
 INSTANCE_NAME="wikitolearn"
fi

docker exec -ti ${INSTANCE_NAME}-websrv /var/www/WikiToLearn/init-docker.sh
