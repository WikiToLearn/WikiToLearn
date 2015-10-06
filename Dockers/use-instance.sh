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

echo "Bringing up "${W2L_INSTALNCE_NAME}"..."

docker inspect wikitolearn-haproxy &> /dev/null
if [[ $? -eq 0 ]] ; then
 docker stop wikitolearn-haproxy
 docker rm wikitolearn-haproxy
fi

if [[ "$W2L_USE_INTERNAL_MAILSRV" == "1" ]] ; then
 MAIL_SRV_LINK="--link ${W2L_INSTANCE_NAME}-mailsrv:mail"
 MAIL_PORTS=" -p 25:25 -p 110:110 -p 143:143 -p 587:587 -p 993:993 -p 995:995"
else
 MAIL_SRV_LINK="--add-host mail:127.0.0.1"
fi


docker run -d --name wikitolearn-haproxy \
 -p 80:80 \
 -p 443:443 \
 -p 8000:8000 \
 $MAIL_PORTS \
 --link ${W2L_INSTANCE_NAME}-websrv:websrv \
 --link ${W2L_INSTANCE_NAME}-ocg:ocg \
 $MAIL_SRV_LINK \
 $W2L_DOCKER_HAPROXY
