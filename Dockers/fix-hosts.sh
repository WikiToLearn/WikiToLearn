#!/bin/bash
WEBSRV_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" wikitolearn-websrv)
OCG_IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" wikitolearn-ocg)

for docker in wikitolearn-websrv wikitolearn-ocg ; do
 for web_host in {de,en,es,fr,it,pool,shared}.wikitolearn.org ; do
  docker exec $docker sed '/'$web_host'/d' /etc/hosts | docker exec -i $docker tee /tmp/tmp_hosts
  docker exec $docker cat /tmp/tmp_hosts | docker exec -i $docker tee /etc/hosts
  echo $WEBSRV_IP" "$web_host | docker exec -i $docker tee -a /etc/hosts
 done

 for ocg_host in ocg.wikitolearn.org ; do
  docker exec $docker sed '/'$ocg_host'/d' /etc/hosts | docker exec -i $docker tee /tmp/tmp_hosts
  docker exec $docker cat /tmp/tmp_hosts | docker exec -i $docker tee /etc/hosts
  echo $OCG_IP" "$ocg_host | docker exec -i $docker tee -a /etc/hosts
 done

done
