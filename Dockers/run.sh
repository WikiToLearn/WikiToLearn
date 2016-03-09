#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

./create_instance_config.sh

if [[ ! -f instance_config.conf ]] ; then
 echo "Missing instance_config.conf"
 exit 1
fi

. ./instance_config.conf

[[ -z "$WTL_INIT_DB" ]] && export WTL_INIT_DB=0
[[ -z "$WTL_PRODUCTION" ]] && WTL_PRODUCTION=1

if [ "$WTL_BACKUP_ENABLED" == "1" ] ; then
 if [ ! -d "$WTL_BACKUP_PATH" ] ; then
  echo "Missing $WTL_BACKUP_PATH"
  exit 1
 fi
fi

test -d configs/ || mkdir -p configs/
test -d configs/secrets/ || mkdir -p configs/secrets/

export MORE_ARGS=" -e WTL_PRODUCTION="$WTL_PRODUCTION" "
if [[ "$WTL_PRODUCTION=" == "1" ]] ; then
        export MORE_ARGS=" --restart=always "$MORE_ARGS
fi

# parsoid running
docker ps | grep ${WTL_INSTANCE_NAME}-parsoid &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${WTL_INSTANCE_NAME}-parsoid &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${WTL_INSTANCE_NAME}-parsoid
 else
  docker run -ti $MORE_ARGS --hostname parsoid --name ${WTL_INSTANCE_NAME}-parsoid -d $WTL_DOCKER_PARSOID
 fi
fi

# mathoid running
docker ps | grep ${WTL_INSTANCE_NAME}-mathoid &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${WTL_INSTANCE_NAME}-mathoid &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${WTL_INSTANCE_NAME}-mathoid
 else
  if [[ "$MATHOID_NUM_WORKERS" == "" ]] ; then
   export MATHOID_NUM_WORKERS=40
  fi
  docker run -ti $MORE_ARGS --hostname mathoid --name ${WTL_INSTANCE_NAME}-mathoid -e NUM_WORKERS=$MATHOID_NUM_WORKERS -d $WTL_DOCKER_MATHOID
 fi
fi


# run mamecached
docker ps | grep ${WTL_INSTANCE_NAME}-memcached &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${WTL_INSTANCE_NAME}-memcached &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${WTL_INSTANCE_NAME}-memcached
 else
  docker run -ti $MORE_ARGS --hostname memcached --name ${WTL_INSTANCE_NAME}-memcached -d $WTL_DOCKER_MEMCACHED
 fi
fi

# run mysql and init
docker ps | grep ${WTL_INSTANCE_NAME}-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${WTL_INSTANCE_NAME}-mysql &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${WTL_INSTANCE_NAME}-mysql
 else
  test -d configs/secrets/ || mkdir -p configs/secrets/
  ROOT_PWD=$(echo $RANDOM$RANDOM$(date +%s) | sha256sum | base64 | head -c 32 )
  docker run -ti $MORE_ARGS -v ${WTL_INSTANCE_NAME}-var-lib-mysql:/var/lib/mysql --hostname mysql --name ${WTL_INSTANCE_NAME}-mysql -e MYSQL_ROOT_PASSWORD=$ROOT_PWD -d $WTL_DOCKER_MYSQL
  IP=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" ${WTL_INSTANCE_NAME}-mysql)
  echo "[client]" > configs/my.cnf
  echo "user=root" >> configs/my.cnf
  echo "password=$ROOT_PWD" >> configs/my.cnf

  echo "Waiting mysql init..."
  false
  while [[ $? -ne 0 ]] ; do
   sleep 1
   docker logs ${WTL_INSTANCE_NAME}-mysql | grep "MySQL init process done. Ready for start up." &> /dev/null
  done

  {
   echo "[client]"
   echo "user=root"
   echo "password=$ROOT_PWD"
  } | docker exec -i ${WTL_INSTANCE_NAME}-mysql tee /root/.my.cnf

  echo "Attesa mysql online..."
  {
  while ! docker exec -i ${WTL_INSTANCE_NAME}-mysql mysql -e "SHOW DATABASES" ; do
   sleep 1
  done
  } &> /dev/null

  {
   # to add a domain you must add the line in apache config file apache2/common/WikiToLearn.conf in WebSrv repo
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
  } | docker exec -i ${WTL_INSTANCE_NAME}-mysql mysql

  docker exec -i ${WTL_INSTANCE_NAME}-mysql mysql -e "show databases like '%wiki%';" | grep wikitolearn | while read db; do
   pass=$(echo $RANDOM$RANDOM$(date +%s) | sha256sum | base64 | head -c 32)
   user=${db::-11}
   {
    echo "GRANT ALL PRIVILEGES ON * . * TO '"$user"'@'%' IDENTIFIED BY '"$pass"';"
   } | docker exec -i ${WTL_INSTANCE_NAME}-mysql mysql

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
docker ps | grep ${WTL_INSTANCE_NAME}-ocg &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${WTL_INSTANCE_NAME}-ocg &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${WTL_INSTANCE_NAME}-ocg
 else
  langs="$(find configs/secrets/ -name *wikitolearn.php -exec basename {} \; | sed 's/wikitolearn.php//g' | grep -v shared)"
  echo $langs
  if [[ "$WTL_SKIP_OCG_DOCKER" == "0" ]] ; then
   WTL_DOCKER_OCG_USE="$WTL_DOCKER_OCG"
   WTL_OCG_CMD=""
  else
   WTL_DOCKER_OCG_USE="debian:8"
   WTL_OCG_CMD="sleep infinity"
  fi
  docker run -ti $MORE_ARGS -v wikitolearn-ocg:/tmp/ocg/ocg-output/ --hostname ocg --link ${WTL_INSTANCE_NAME}-parsoid:parsoid -e langs="$langs" --name ${WTL_INSTANCE_NAME}-ocg -d $WTL_DOCKER_OCG_USE $WTL_OCG_CMD
 fi
fi

# run websrv docker linked to other
docker ps | grep ${WTL_INSTANCE_NAME}-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 docker ps -a | grep ${WTL_INSTANCE_NAME}-websrv &> /dev/null
 if [[ $? -eq 0 ]] ; then
  docker start ${WTL_INSTANCE_NAME}-websrv
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

  docker run -ti $MORE_ARGS -v ${WTL_INSTANCE_NAME}-var-log-apache2:/var/log/apache2 --hostname websrv \
   $CERTS_MOUNT \
   -e USER_UID=$EXT_UID \
   -e USER_GID=$EXT_GID \
   -v $(readlink -f $(dirname $(readlink -f $0))"/.."):/var/www/WikiToLearn/ --name ${WTL_INSTANCE_NAME}-websrv \
   --link ${WTL_INSTANCE_NAME}-mysql:mysql \
   --link ${WTL_INSTANCE_NAME}-memcached:memcached \
   --link ${WTL_INSTANCE_NAME}-ocg:ocg \
   --link ${WTL_INSTANCE_NAME}-mathoid:mathoid \
   --link ${WTL_INSTANCE_NAME}-parsoid:parsoid \
   -d $WTL_DOCKER_WEBSRV

  if [[ "$WTL_RELAY_HOST" != "" ]] ; then
   {
    docker exec ${WTL_INSTANCE_NAME}-websrv sed '/^mailhub/d' /etc/ssmtp/ssmtp.conf
    echo "mailhub=${WTL_RELAY_HOST}" | docker exec -i ${WTL_INSTANCE_NAME}-websrv tee -a /etc/ssmtp/ssmtp.conf
   } &> /dev/null
  fi
 fi
fi

rsync -a configs/secrets/ ../secrets/
