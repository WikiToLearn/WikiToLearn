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

for docker in ${W2L_INSTANCE_NAME}-parsoid ${W2L_INSTANCE_NAME}-ocg ; do
 web_hosts=$(for subdom in $(find ../secrets/ -name *wikitolearn.php -exec basename {} \; | sed 's/wikitolearn.php//g'); do
  echo ${subdom}".tuttorotto.biz "
 done)

 echo "In "$docker" fixing "$web_hosts" to "$WEBSRV_IP
 {
  docker exec $docker sed '/HOSTTUTTOROTTOBIZFIX1/d' /etc/hosts | docker exec -i $docker tee /tmp/tmp_hosts
  docker exec $docker cat /tmp/tmp_hosts | docker exec -i $docker tee /etc/hosts
  echo $WEBSRV_IP" HOSTTUTTOROTTOBIZFIX1 "$web_hosts | docker exec -i $docker tee -a /etc/hosts
 } &> /dev/null

done
