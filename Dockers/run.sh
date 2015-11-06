#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

./create_instance_config.sh

if [[ ! -f instance_config.conf ]] ; then
 echo "Missing instance_config.conf"
 exit 1
fi

. ./instance_config.conf

[[ -z "$W2L_INIT_DB" ]] && export W2L_INIT_DB=0
[[ -z "$W2L_PRODUCTION" ]] && W2L_PRODUCTION=1

if [ "$W2L_BACKUP_ENABLED" == "1" ] ; then
 if [ ! -d "$W2L_BACKUP_PATH" ] ; then
  echo "Missing $W2L_BACKUP_PATH"
  exit 1
 fi
fi

which mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "'mysql' command not found"
 exit 1
fi

test -d configs/ || mkdir -p configs/
test -d configs/secrets/ || mkdir -p configs/secrets/

export MORE_ARGS=" -e W2L_PRODUCTION="$W2L_PRODUCTION" "
if [[ "$W2L_PRODUCTION=" == "1" ]] ; then
        export MORE_ARGS=" --restart=always "$MORE_ARGS
fi

# run mamecached
docker ps | grep ${W2L_INSTANCE_NAME}-memcached &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${W2L_INSTANCE_NAME}-memcached &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${W2L_INSTANCE_NAME}-memcached
 else
  docker run -ti $MORE_ARGS --hostname memcached.wikitolearn.org --name ${W2L_INSTANCE_NAME}-memcached -d $W2L_DOCKER_MEMCACHED
 fi
fi

# run mysql and init
docker ps | grep ${W2L_INSTANCE_NAME}-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${W2L_INSTANCE_NAME}-mysql &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${W2L_INSTANCE_NAME}-mysql
 else
  test -d configs/secrets/ || mkdir -p configs/secrets/
  ROOT_PWD=$(echo $RANDOM$RANDOM$(date +%s) | sha256sum | base64 | head -c 32 )
  if [[ "$W2L_DOCKER_MOUNT_DIRS" == "1" ]] ; then
   MOUNT_DIR="-v '$W2L_DOCKER_MYSQL_DATA_PATH':/var/lib/mysql"
  else
   MOUNT_DIR=""
  fi
  docker run -ti $MORE_ARGS $MOUNT_DIR --hostname mysql.wikitolearn.org --name ${W2L_INSTANCE_NAME}-mysql -e MYSQL_ROOT_PASSWORD=$ROOT_PWD -d $W2L_DOCKER_MYSQL
  IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ${W2L_INSTANCE_NAME}-mysql)
  echo "[client]" > configs/my.cnf
  echo "user=root" >> configs/my.cnf
  echo "password=$ROOT_PWD" >> configs/my.cnf

  echo "Waiting mysql init..."
  false
  while [[ $? -ne 0 ]] ; do
   sleep 1
   docker logs ${W2L_INSTANCE_NAME}-mysql | grep "MySQL init process done. Ready for start up." &> /dev/null
  done

  {
   echo "[client]"
   echo "user=root"
   echo "password=$ROOT_PWD"
  } | docker exec -i ${W2L_INSTANCE_NAME}-mysql tee /root/.my.cnf

  echo "Attesa mysql online..."
  {
  while ! docker exec -i ${W2L_INSTANCE_NAME}-mysql mysql -e "SHOW DATABASES" ; do
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
   echo "CREATE DATABASE IF NOT EXISTS svwikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS metawikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS poolwikitolearn;"
   echo "CREATE DATABASE IF NOT EXISTS sharedwikitolearn;"
  } | docker exec -i ${W2L_INSTANCE_NAME}-mysql mysql

  docker exec -i ${W2L_INSTANCE_NAME}-mysql mysql -e "show databases like '%wiki%';" | grep wikitolearn | while read db; do
   pass=$(echo $RANDOM$RANDOM$(date +%s) | sha256sum | base64 | head -c 32)
   user=${db::-11}
   {
    echo "GRANT ALL PRIVILEGES ON * . * TO '"$user"'@'172.17.%' IDENTIFIED BY '"$pass"';"
   } | docker exec -i ${W2L_INSTANCE_NAME}-mysql mysql

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
docker ps | grep ${W2L_INSTANCE_NAME}-ocg &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${W2L_INSTANCE_NAME}-ocg &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${W2L_INSTANCE_NAME}-ocg
 else
  langs="$(find configs/secrets/ -name *wikitolearn.php -exec basename {} \; | sed 's/wikitolearn.php//g' | grep -v shared)"
  echo $langs
  docker run -ti $MORE_ARGS --hostname ocg.wikitolearn.org -e langs="$langs" --name ${W2L_INSTANCE_NAME}-ocg -d $W2L_DOCKER_OCG
 fi
fi

# run websrv docker linked to other
docker ps | grep ${W2L_INSTANCE_NAME}-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${W2L_INSTANCE_NAME}-websrv &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${W2L_INSTANCE_NAME}-websrv
 else
  if [ ! -f configs/secrets/secrets.php ] ; then
   WG_SECRET_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)
cat > configs/secrets/secrets.php << EOL
<?php

\$wgSecretKey = "$WG_SECRET_KEY";

\$virtualFactoryUser = "test";
\$virtualFactoryPass = "test";

?>
EOL
  fi

  if [[ "$W2L_DOCKER_MOUNT_DIRS" == "1" ]] ; then
   MOUNT_DIR="-v '$W2L_DOCKER_WEBSRV_LOG_PATH':/var/log/apache2"
  else
   MOUNT_DIR=""
  fi

  EXT_UID=$(id -u)
  EXT_GID=$(id -g)
  if [[ "$EXT_UID" == "0" ]] ; then
   EXT_UID=1000
  fi
  if [[ "$EXT_GID" == "0" ]] ; then
   EXT_GID=1000
  fi
  MAIL_SRV_LINK=""

  CERTS_MOUNT=""
  if [[ -d certs/ ]] ; then
   CERTS_MOUNT=" -v "$(pwd)"/certs/:/certs/:ro "
  fi

  docker run -ti $MORE_ARGS $MOUNT_DIR --hostname websrv.wikitolearn.org \
   $CERTS_MOUNT \
   -e USER_UID=$EXT_UID \
   -e USER_GID=$EXT_GID \
   -v $(readlink -f $(dirname $(readlink -f $0))"/.."):/var/www/WikiToLearn/ --name ${W2L_INSTANCE_NAME}-websrv \
   --link ${W2L_INSTANCE_NAME}-mysql:mysql \
   --link ${W2L_INSTANCE_NAME}-memcached:memcached \
   --link ${W2L_INSTANCE_NAME}-ocg:ocg \
   -d $W2L_DOCKER_WEBSRV

  if [[ "$W2L_RELAY_HOST" != "" ]] ; then
   {
    docker exec ${W2L_INSTANCE_NAME}-websrv sed '/^mailhub/d' /etc/ssmtp/ssmtp.conf
    echo "mailhub=${W2L_RELAY_HOST}" | docker exec -i ${W2L_INSTANCE_NAME}-websrv tee -a /etc/ssmtp/ssmtp.conf
   } &> /dev/null
  fi
 fi
fi

rsync -a configs/secrets/ ../secrets/
