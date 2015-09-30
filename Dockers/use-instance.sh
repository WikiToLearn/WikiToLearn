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
   server host-web websrv:80 check
listen wikitolearn-https 0.0.0.0:443
   server host-web websrv:443 check

listen wikitolearn-ocg 0.0.0.0:8000
   server host-ocg ocg:8000 check

listen wikitolearn-smtp 0.0.0.0:25
   server host-mail mail:25 check
listen wikitolearn-pop3 0.0.0.0:110
   server host-mail mail:110 check
listen wikitolearn-imap 0.0.0.0:143
   server host-mail mail:143 check
listen wikitolearn-submission 0.0.0.0:587
   server host-mail mail:587 check
listen wikitolearn-imaps 0.0.0.0:993
   server host-mail mail:993 check
listen wikitolearn-pop3s 0.0.0.0:995
   server host-mail mail:995 check
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
 --link ${W2L_INSTANCE_NAME}-websrv:websrv \
 --link ${W2L_INSTANCE_NAME}-ocg:ocg \
 --link ${W2L_INSTANCE_NAME}-mailsrv:mail \
 -v $(pwd)/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro $W2L_DOCKER_HAPROXY
