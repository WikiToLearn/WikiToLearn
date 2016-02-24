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

{
 docker exec -ti ${W2L_INSTANCE_NAME}-mysql mysqldump itwikitolearn
} > ../empty-wikitolearn.sql
{
 docker exec -ti ${W2L_INSTANCE_NAME}-mysql mysqldump sharedwikitolearn
} > ../sharedwikitolearn.sql
