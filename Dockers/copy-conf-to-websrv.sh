#!/bin/bash
docker inspect wikitolearn-websrv &> /dev/null

if [[ $? -eq 0 ]] ; then
 WIKITOLEARN_DIR=$(docker inspect -f "{{ .HostConfig.Binds }}" wikitolearn-websrv  | awk -F":" '{ print $1 }' | cut -c 2-)
 echo "Copy to "$WIKITOLEARN_DIR
 test -f $WIKITOLEARN_DIR"/secrets/" || mkdir -p $WIKITOLEARN_DIR"/secrets/"
 cp configs/secrets/* $WIKITOLEARN_DIR"/secrets/"
else
 echo "Missing wikitolearn-websrv"
fi
