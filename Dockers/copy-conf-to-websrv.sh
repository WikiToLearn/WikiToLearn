#!/bin/bash
docker inspect wikifm-websrv &> /dev/null

if [[ $? -eq 0 ]] ; then
 WIKIFM_DIR=$(docker inspect -f "{{ .HostConfig.Binds }}" wikifm-websrv  | awk -F":" '{ print $1 }' | cut -c 2-)
 echo "Copy to "$WIKIFM_DIR
 test -f $WIKIFM_DIR"/secrets/" || mkdir -p $WIKIFM_DIR"/secrets/"
 cp configs/secrets/* $WIKIFM_DIR"/secrets/"
else
 echo "Missing wikifm-websrv"
fi
