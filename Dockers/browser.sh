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

echo "Bringing up "${W2L_INSTANCE_NAME}"..."

docker run --rm -e DISPLAY=$DISPLAY -ti --name broswer-in-docker \
 --hostname broswer-in-docker --privileged \
 --link ${W2L_INSTANCE_NAME}-websrv:www.wikitolearn.org \
 --link ${W2L_INSTANCE_NAME}-websrv:pool.wikitolearn.org \
 --link ${W2L_INSTANCE_NAME}-websrv:meta.wikitolearn.org \
 --link ${W2L_INSTANCE_NAME}-websrv:it.wikitolearn.org \
 --link ${W2L_INSTANCE_NAME}-websrv:en.wikitolearn.org \
 --link ${W2L_INSTANCE_NAME}-websrv:de.wikitolearn.org \
 --link ${W2L_INSTANCE_NAME}-websrv:es.wikitolearn.org \
 --link ${W2L_INSTANCE_NAME}-websrv:fr.wikitolearn.org \
 --link ${W2L_INSTANCE_NAME}-websrv:pt.wikitolearn.org \
 --link ${W2L_INSTANCE_NAME}-websrv:sv.wikitolearn.org \
 -v /tmp/.X11-unix:/tmp/.X11-unix  -v $HOME:/home/devuser/data \
 wikitolearn/broswer-in-docker:0.1
