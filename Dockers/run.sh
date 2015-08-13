#!/bin/bash
WIKIFM_DIR=""
if [[ "$1" != "" ]] ; then
 WIKIFM_DIR="$(readlink -f $1)"
else
 WIKIFM_DIR=$(readlink -f $(dirname $(readlink -f $0))"/..")
fi

if [[ ! -d $WIKIFM_DIR ]] || [[ "$WIKIFM_DIR" == "" ]] ; then
 echo "Usage "$0" <wikidir>"
 exit 1
else
 echo "Use "$WIKIFM_DIR" as WikiFM dir"
fi

docker inspect wikifm-websrv &> /dev/null
if [[ $? -eq 0 ]] ; then
 WIKIFM_DIR_OLD=$(docker inspect -f "{{ .HostConfig.Binds }}" wikifm-websrv  | awk -F":" '{ print $1 }' | cut -c 2-)
 if [[ $WIKIFM_DIR != $WIKIFM_DIR_OLD ]] ; then
  echo "You must destroy old wikifm-websrv to change working dir"
  exit 1
 fi
fi


if [[ ! -d $WIKIFM_DIR ]] ; then
 echo "Dir "$WIKIFM_DIR" not exist"
 exit
fi

#docker pull wikifm/ocg
#docker pull wikifm/mailsrv
#docker pull wikifm/websrv
#docker pull memcached
#docker pull mysql:5.6

# run mamecached
docker ps | grep wikifm-memcached &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikifm-memcached &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikifm-memcached
 else
  docker run --hostname memcached.wikifm.org --name wikifm-memcached -d memcached
 fi
fi


docker ps | grep wikifm-mailsrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikifm-mailsrv &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikifm-mailsrv
 else
  docker run --hostname mail.wikifm.org --name wikifm-mailsrv -d wikifm/mailsrv
 fi
fi


# run mysql and init
docker ps | grep wikifm-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikifm-mysql &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikifm-mysql
 else
  test -d configs/secrets/ || mkdir -p configs/secrets/
  ROOT_PWD=$(echo $RANDOM$RANDOM$(date +%s) | sha256sum | base64 | head -c 32 )
  docker run --hostname mysql.wikifm.org --name wikifm-mysql -e MYSQL_ROOT_PASSWORD=$ROOT_PWD -d mysql:5.6
  IP=$(docker inspect wikifm-mysql  | grep \"IPAddress\" | grep  -E -o '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)')
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
   echo "CREATE DATABASE IF NOT EXISTS dewikifm;"
   echo "CREATE DATABASE IF NOT EXISTS enwikifm;"
   echo "CREATE DATABASE IF NOT EXISTS eswikifm;"
   echo "CREATE DATABASE IF NOT EXISTS frwikifm;"
   echo "CREATE DATABASE IF NOT EXISTS itwikifm;"
   echo "CREATE DATABASE IF NOT EXISTS poolwikifm;"
   echo "CREATE DATABASE IF NOT EXISTS sharedwikifm;"
  } | mysql --defaults-file=configs/my.cnf -h $IP

  mysql --defaults-file=configs/my.cnf -h $IP -e "show databases like '%wiki%';" | grep wikifm | while read db; do
   pass=$(echo $RANDOM$RANDOM$(date +%s) | sha256sum | base64 | head -c 32)
   user=$db
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
docker ps | grep wikifm-ocg &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikifm-ocg &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikifm-ocg
 else
  docker run --hostname ocg.wikifm.org --name wikifm-ocg -p 8000:8000 -d wikifm/ocg
 fi
fi

# run websrv docker linked to other
docker ps | grep wikifm-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep wikifm-websrv &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start wikifm-websrv
 else
cat > configs/secrets/secrets.php << EOL
<?php

\$wgSecretKey = "0000000000000000000000000000000000000000000000000000000000000000";

\$virtualFactoryUser = "test";
\$virtualFactoryPass = "test";

?>
EOL

  docker run --hostname websrv.wikifm.org -v $WIKIFM_DIR:/srv/WikiFM --name wikifm-websrv \
   -e UID=$(id -u) \
   -e GID=$(id -g) \
   --privileged=true \
   --link wikifm-mysql:mysql \
   --link wikifm-memcached:memcached \
   --link wikifm-ocg:ocg \
   --link wikifm-mailsrv:mail \
   -p 80:80 -p 443:443 -d wikifm/websrv
 fi
fi
