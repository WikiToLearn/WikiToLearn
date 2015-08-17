#!/bin/bash
WIKITOLEARN_DIR=""
if [[ "$1" != "" ]] ; then
 WIKITOLEARN_DIR="$(readlink -f $1)"
else
 WIKITOLEARN_DIR=$(readlink -f $(dirname $(readlink -f $0))"/..")
fi

if [[ ! -d $WIKITOLEARN_DIR ]] || [[ "$WIKITOLEARN_DIR" == "" ]] ; then
 echo "Usage "$0" <wikidir>"
 exit 1
else
 echo "Use "$WIKITOLEARN_DIR" as WikiToLearn dir"
fi

docker inspect wikitolearn-websrv &> /dev/null
if [[ $? -eq 0 ]] ; then
 WIKITOLEARN_DIR_OLD=$(docker inspect -f "{{ .HostConfig.Binds }}" wikitolearn-websrv  | awk -F":" '{ print $1 }' | cut -c 2-)
 if [[ $WIKITOLEARN_DIR != $WIKITOLEARN_DIR_OLD ]] ; then
  echo "You must destroy old wikitolearn-websrv to change working dir"
  exit 1
 fi
fi


if [[ ! -d $WIKITOLEARN_DIR ]] ; then
 echo "Dir "$WIKITOLEARN_DIR" not exist"
 exit
fi

#docker pull wikifm/ocg
#docker pull wikifm/mailsrv
#docker pull wikifm/websrv
#docker pull memcached
#docker pull mysql:5.6

# run mamecached
docker ps | grep wikitolearn-memcached &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikitolearn-memcached &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikitolearn-memcached
 else
  docker run --hostname memcached.wikitolearn.org --name wikitolearn-memcached -d memcached
 fi
fi


docker ps | grep wikitolearn-mailsrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikitolearn-mailsrv &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikitolearn-mailsrv
 else
  docker run --hostname mail.wikitolearn.org --name wikitolearn-mailsrv -d wikifm/mailsrv
 fi
fi


# run mysql and init
docker ps | grep wikitolearn-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikitolearn-mysql &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikitolearn-mysql
 else
  test -d configs/secrets/ || mkdir -p configs/secrets/
  ROOT_PWD=$(echo $RANDOM$RANDOM$(date +%s) | sha256sum | base64 | head -c 32 )
  docker run --hostname mysql.wikitolearn.org --name wikitolearn-mysql -e MYSQL_ROOT_PASSWORD=$ROOT_PWD -d mysql:5.6
  IP=$(docker inspect wikitolearn-mysql  | grep \"IPAddress\" | grep  -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)')
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
    echo "?>"
   } > configs/secrets/$db.php
  done
 fi
fi

# run ocg docker
docker ps | grep wikitolearn-ocg &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikitolearn-ocg &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikitolearn-ocg
 else
  docker run --hostname ocg.wikitolearn.org --name wikitolearn-ocg -p 8000:8000 -d wikifm/ocg
 fi
fi

# run websrv docker linked to other
docker ps | grep wikitolearn-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikitolearn-websrv &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikitolearn-websrv
 else
cat > configs/secrets/secrets.php << EOL
<?php

\$wgSecretKey = "0000000000000000000000000000000000000000000000000000000000000000";

\$virtualFactoryUser = "test";
\$virtualFactoryPass = "test";

?>
EOL

  docker run --hostname websrv.wikitolearn.org -v $WIKITOLEARN_DIR:/srv/WikiToLearn --name wikitolearn-websrv \
   -e UID=$(id -u) \
   -e GID=$(id -g) \
   --privileged=true \
   --link wikitolearn-mysql:mysql \
   --link wikitolearn-memcached:memcached \
   --link wikitolearn-ocg:ocg \
   --link wikitolearn-mailsrv:mail \
   -p 80:80 -p 443:443 -d wikifm/websrv
 fi
fi
