#!/bin/bash

cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ -f instance_name.conf ]] ; then
 . ./instance_name.conf
fi

if [[ "$INSTANCE_NAME" == "" ]] ; then
 INSTANCE_NAME="wikitolearn"
fi

docker inspect ${INSTANCE_NAME}-websrv &> /dev/null

if [[ $? -eq 0 ]] ; then
 WIKITOLEARN_DIR=$(docker inspect -f "{{ .HostConfig.Binds }}" ${INSTANCE_NAME}-websrv  | awk -F":" '{ print $1 }' | cut -c 2-)
 echo "Copy to "$WIKITOLEARN_DIR
 test -f $WIKITOLEARN_DIR"/secrets/" || mkdir -p $WIKITOLEARN_DIR"/secrets/"
 cp configs/secrets/* $WIKITOLEARN_DIR"/secrets/"
else
 echo "Missing ${INSTANCE_NAME}-websrv"
fi
