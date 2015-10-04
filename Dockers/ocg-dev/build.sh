#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")/.."

if [[ ! -f ./instance_config.conf ]] ; then
 echo "Missing ./instance_config.conf file"
 exit 1
fi

. ./instance_config.conf

if [[ "$W2L_INSTANCE_NAME" == "" ]] ; then
 echo "Missing key env variabile W2L_INSTANCE_NAME"
 exit 1
fi

test -d ocg-dev/mw-ocg || git clone https://github.com/WikiToLearn/mw-ocg.git ocg-dev/mw-ocg --recursive

docker inspect ${W2L_INSTANCE_NAME}-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing ${W2L_INSTANCE_NAME}-websrv"
 exit 1
fi

sed -i '/FROM/d' ocg-dev/Dockerfile
sed -i '1iFROM '$W2L_DOCKER_OCG ocg-dev/Dockerfile
if [[ $? -eq 0 ]] ; then
 docker stop ${W2L_INSTANCE_NAME}-ocg
 docker rm ${W2L_INSTANCE_NAME}-ocg

 docker rmi ocg:dev
 pwd
 docker build -t ocg:dev ocg-dev

 docker run -ti --hostname ocg.wikitolearn.org --name ${W2L_INSTANCE_NAME}-ocg -d ocg:dev
 echo "Now you may run fix-hosts.sh"
fi
sed -i '/FROM/d' ocg-dev/Dockerfile
sed -i '1iFROM wikifm/ocg' ocg-dev/Dockerfile
