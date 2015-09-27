#!/bin/bash

cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ -f instance_name.conf ]] ; then
 . ./instance_name.conf
fi

if [[ "$INSTANCE_NAME" == "" ]] ; then
    INSTANCE_NAME="wikitolearn-dev"
fi


echo "Bringing up "$INSTANCE_NAME"..."

{
export W2L_IP_WEBSRV=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ${INSTANCE_NAME}-websrv)
} &> /dev/null
docker inspect ${INSTANCE_NAME}-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing WebSrv"
 exit 1
fi

{
export W2L_IP_OCG=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ${INSTANCE_NAME}-ocg)
} &> /dev/null
docker inspect ${INSTANCE_NAME}-ocg &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing websrv"
 exit 1
fi

{
export W2L_IP_MYSQL=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ${INSTANCE_NAME}-mysql)
} &> /dev/null
docker inspect ${INSTANCE_NAME}-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing mysql"
 exit 1
fi

{
export W2L_IP_MAILSRV=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ${INSTANCE_NAME}-mailsrv)
} &> /dev/null
docker inspect ${INSTANCE_NAME}-mailsrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing mailsrv"
 exit 1
fi

{
export W2L_IP_MEMCACHED=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ${INSTANCE_NAME}-memcached)
} &> /dev/null
docker inspect ${INSTANCE_NAME}-memcached &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing memcached"
 exit 1
fi

cat << EOF > $(pwd)/haproxy.cfg
global
    stats timeout 30s

defaults
   mode    tcp
   timeout connect 500
   timeout client  5000
   timeout server  5000
   balance roundrobin

listen wikitolearn-http 0.0.0.0:80
   server host-web ${W2L_IP_WEBSRV}:80 check
listen wikitolearn-https 0.0.0.0:443
   server host-web ${W2L_IP_WEBSRV}:443 check

listen wikitolearn-ocg 0.0.0.0:8000
   server host-ocg ${W2L_IP_OCG}:8000 check

listen wikitolearn-smtp 0.0.0.0:25
   server host-mail ${W2L_IP_MAILSRV}:25 check
listen wikitolearn-pop3 0.0.0.0:110
   server host-mail ${W2L_IP_MAILSRV}:110 check
listen wikitolearn-imap 0.0.0.0:143
   server host-mail ${W2L_IP_MAILSRV}:143 check
listen wikitolearn-submission 0.0.0.0:587
   server host-mail ${W2L_IP_MAILSRV}:587 check
listen wikitolearn-imaps 0.0.0.0:993
   server host-mail ${W2L_IP_MAILSRV}:993 check
listen wikitolearn-pop3s 0.0.0.0:995
   server host-mail ${W2L_IP_MAILSRV}:995 check
EOF

docker inspect wikitolearn-haproxy &> /dev/null
if [[ $? -eq 0 ]] ; then
 docker stop wikitolearn-haproxy
 docker rm wikitolearn-haproxy
fi

docker run -d --name wikitolearn-haproxy \
 -p 80:80 \
 -p 443:443 \
 -p 8000:8000 \
 -p 25:25 \
 -p 110:110 \
 -p 143:143 \
 -p 587:587 \
 -p 993:993 \
 -p 995:995 \
 -v $(pwd)/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro haproxy:1.5
