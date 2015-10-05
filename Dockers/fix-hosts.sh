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
 docker exec -ti $docker cat /etc/hosts
 continue
 web_hosts=$(for subdom in $(find ../secrets/ -name *wikitolearn.php -exec basename {} \; | sed 's/wikitolearn.php//g'); do
  echo ${subdom}".wikitolearn.org "
 done)
 echo $web_hosts" to "$WEBSRV_IP
 {
  docker exec $docker sed '/HOSTFIX1/d' /etc/hosts | docker exec -i $docker tee /tmp/tmp_hosts
  docker exec $docker cat /tmp/tmp_hosts | docker exec -i $docker tee /etc/hosts
  echo $WEBSRV_IP" HOSTFIX1 "$web_hosts | docker exec -i $docker tee -a /etc/hosts
 } &> /dev/null

 ocg_hosts=$(for ocg_host in ocg ocg.wikitolearn.org ; do
  echo $ocg_host" "
 done)
 echo "Fixing "$ocg_hosts" to "$OCG_IP
 {
  docker exec $docker sed '/HOSTFIX2/d' /etc/hosts | docker exec -i $docker tee /tmp/tmp_hosts
  docker exec $docker cat /tmp/tmp_hosts | docker exec -i $docker tee /etc/hosts
  echo $OCG_IP" HOSTFIX2 "$ocg_hosts | docker exec -i $docker tee -a /etc/hosts
 } &> /dev/null

done
