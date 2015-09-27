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

WEBSRV_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ${W2L_INSTANCE_NAME}-websrv)
OCG_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ${W2L_INSTANCE_NAME}-ocg)

for docker in ${W2L_INSTANCE_NAME}-websrv ${W2L_INSTANCE_NAME}-ocg ; do
 for subdom in $(find ../secrets/ -name *wikitolearn.php -exec basename {} \; | sed 's/wikitolearn.php//g'); do
  web_host=${subdom}".wikitolearn.org"
  docker exec $docker sed '/'$web_host'/d' /etc/hosts | docker exec -i $docker tee /tmp/tmp_hosts
  docker exec $docker cat /tmp/tmp_hosts | docker exec -i $docker tee /etc/hosts
  echo $WEBSRV_IP" "$web_host | docker exec -i $docker tee -a /etc/hosts
 done

 for ocg_host in ocg ocg.wikitolearn.org ; do
  docker exec $docker sed '/'$ocg_host'/d' /etc/hosts | docker exec -i $docker tee /tmp/tmp_hosts
  docker exec $docker cat /tmp/tmp_hosts | docker exec -i $docker tee /etc/hosts
  echo $OCG_IP" "$ocg_host | docker exec -i $docker tee -a /etc/hosts
 done

done
