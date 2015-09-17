#!/bin/bash

cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

which mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "'mysql' command not found"
 exit 1
fi

WIKITOLEARN_DIR=""
if [[ "$1" != "" ]] ; then
 WIKITOLEARN_DIR="$(readlink -f $1)"
else
 WIKITOLEARN_DIR=$(readlink -f $(dirname $(readlink -f $0))"/..")
fi

if [[ -f instance_name.conf ]] ; then
 . ./instance_name.conf
fi

if [[ "$INSTANCE_NAME" == "" ]] ; then
 INSTANCE_NAME="wikitolearn"
fi

if [[ ! -d $WIKITOLEARN_DIR ]] || [[ "$WIKITOLEARN_DIR" == "" ]] ; then
 echo "Usage "$0" <wikidir>"
 exit 1
else
 echo "Use "$WIKITOLEARN_DIR" as WikiToLearn dir"
fi

docker inspect ${INSTANCE_NAME}-websrv &> /dev/null
if [[ $? -eq 0 ]] ; then
 WIKITOLEARN_DIR_OLD=$(docker inspect -f "{{ .HostConfig.Binds }}" ${INSTANCE_NAME}-websrv  | awk -F":" '{ print $1 }' | cut -c 2-)
 if [[ $WIKITOLEARN_DIR != $WIKITOLEARN_DIR_OLD ]] ; then
  echo "You must destroy old ${INSTANCE_NAME}-websrv to change working dir"
  exit 1
 fi
fi


if [[ ! -d $WIKITOLEARN_DIR ]] ; then
 echo "Dir "$WIKITOLEARN_DIR" not exist"
 exit
fi

if [[ "$PROD" == "1" ]] ; then
	export MORE_ARGS=" --restart=always -e PROD=1 "
else
	export MORE_ARGS=" -e DEV=1"
fi

# run mamecached
docker ps | grep ${INSTANCE_NAME}-memcached &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${INSTANCE_NAME}-memcached &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${INSTANCE_NAME}-memcached
 else
  docker run $MORE_ARGS --hostname memcached.wikitolearn.org --name ${INSTANCE_NAME}-memcached -d memcached:1.4.24
 fi
fi


docker ps | grep ${INSTANCE_NAME}-mailsrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${INSTANCE_NAME}-mailsrv &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${INSTANCE_NAME}-mailsrv
 else
  docker run $MORE_ARGS --hostname mail.wikitolearn.org --name ${INSTANCE_NAME}-mailsrv -d wikifm/mailsrv:0.1
 fi
fi

echo sysadmin:$MAIL_PASSWORD | docker exec -ti ${INSTANCE_NAME}-mailsrv chpasswd

echo "Email Username: sysadmin"
echo "Email Password: "$MAIL_PASSWORD

# run mysql and init
docker ps | grep ${INSTANCE_NAME}-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${INSTANCE_NAME}-mysql &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${INSTANCE_NAME}-mysql
 else
  test -d configs/secrets/ || mkdir -p configs/secrets/
  ROOT_PWD=$(echo $RANDOM$RANDOM$(date +%s) | sha256sum | base64 | head -c 32 )
  docker run $MORE_ARGS --hostname mysql.wikitolearn.org --name ${INSTANCE_NAME}-mysql -e MYSQL_ROOT_PASSWORD=$ROOT_PWD -d mysql:5.6
  IP=$(docker inspect ${INSTANCE_NAME}-mysql  | grep \"IPAddress\" | grep  -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)')
  echo "[client]" > configs/my.cnf
  echo "user=root" >> configs/my.cnf
  echo "password=$ROOT_PWD" >> configs/my.cnf

  echo "Attesa mysql onlnie..."
  {
  while ! mysql --defaults-file=configs/my.cnf -h $IP -e "SHOW DATABASES" ; do
   sleep 1
  done
  } &> /dev/null

  {
   echo "CREATE DATABASE IF NOT EXISTS dewikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS enwikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS eswikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS frwikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS itwikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS ptwikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS poolwikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS sharedwikitolearn;"
  } | mysql --defaults-file=configs/my.cnf -h $IP

  mysql --defaults-file=configs/my.cnf -h $IP -e "show databases like '%wiki%';" | grep wikitolearn | while read db; do
   pass=$(echo $RANDOM$RANDOM$(date +%s) | sha256sum | base64 | head -c 32)
   user=${db::-11}
   {
    echo "GRANT ALL PRIVILEGES ON * . * TO '"$user"'@'172.17.%' IDENTIFIED BY '"$pass"';"
   } | mysql --defaults-file=configs/my.cnf -h $IP
   {
    echo "<?php"
    echo "\$wgDBuser='"$user"';"
    echo "\$wgDBpassword='"$pass"';"
    echo "\$wgDBname='"$db"';"
    echo "?>"
   } > configs/secrets/$db.php
  done
 fi
fi

# run ocg docker
docker ps | grep ${INSTANCE_NAME}-ocg &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${INSTANCE_NAME}-ocg &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${INSTANCE_NAME}-ocg
 else
  docker run $MORE_ARGS --hostname ocg.wikitolearn.org --name ${INSTANCE_NAME}-ocg -p 8000:8000 -d wikifm/ocg:0.1
 fi
fi

# run websrv docker linked to other
docker ps | grep ${INSTANCE_NAME}-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${INSTANCE_NAME}-websrv &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${INSTANCE_NAME}-websrv
 else
cat > configs/secrets/secrets.php << EOL
<?php

\$wgSecretKey = "0000000000000000000000000000000000000000000000000000000000000000";

\$virtualFactoryUser = "test";
\$virtualFactoryPass = "test";

?>
EOL

  docker run $MORE_ARGS --hostname websrv.wikitolearn.org -v $WIKITOLEARN_DIR:/srv/WikiToLearn --name ${INSTANCE_NAME}-websrv \
   -e UID=$(id -u) \
   -e GID=$(id -g) \
   --privileged=true \
   --link ${INSTANCE_NAME}-mysql:mysql \
   --link ${INSTANCE_NAME}-memcached:memcached \
   --link ${INSTANCE_NAME}-ocg:ocg \
   --link ${INSTANCE_NAME}-mailsrv:mail \
   -p 80:80 -p 443:443 -d wikifm/websrv:0.1
 fi
fi
