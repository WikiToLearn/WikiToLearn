#!/bin/bash

which curl &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing curl on your pc"
 exit 1
fi

cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ ! -f ./instance_config.conf ]] ; then
 echo "Missing ./instance_config.conf file"
 exit 1
fi

. ./instance_config.conf

if [[ "$WTL_INSTANCE_NAME" == "" ]] ; then
 echo "Missing key env variabile WTL_INSTANCE_NAME"
 exit 1
fi

if [[ ! -f /tmp/dumplist.it ]] ; then
 {
  echo Pagina_principale
 } > /tmp/dumplist.it
fi

if [[ ! -f /tmp/dumplist.en ]] ; then
 {
  echo Main_Page
 } > /tmp/dumplist.en
fi

for lang in en it ; do
 curl -d "&templates&curonly&action=submit&pages=$(cat /tmp/dumplist.$lang | hexdump -v -e '/1 "%02x"' | sed 's/\(..\)/%\1/g' )" http://$lang.wikitolearn.org/index.php?title=Special:Export -o "/tmp/developer-dump.$lang.xml"
 docker cp /tmp/developer-dump.$lang.xml ${WTL_INSTANCE_NAME}-websrv:/tmp/
 {
  cat <<EOF
export WIKI=$lang.wikitolearn.org
cd /var/www/WikiToLearn/mediawiki/maintenance/
php importDump.php /tmp/developer-dump.$lang.xml
EOF
 } | docker exec -i ${WTL_INSTANCE_NAME}-websrv bash
done
