#!/bin/bash

which rsync &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing rsync command"
 exit 1
fi

cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ -f instance_name.conf ]] ; then
 . ./instance_name.conf
fi

if [[ "$INSTANCE_NAME" == "" ]] ; then
 INSTANCE_NAME="wikitolearn-dev"
fi

docker inspect ${INSTANCE_NAME}-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing mysql for inscance "${INSTANCE_NAME}-
 exit 1
fi

{
cat configs/my.cnf | docker exec -i ${INSTANCE_NAME}-mysql tee /root/.my.cnf
} > /dev/null

BACKUP_DIR=$1

if [ ! -d $BACKUP_DIR ] ; then
 echo "Missing "$BACKUP_DIR
 exit 1
fi

echo "\$wgReadOnly = 'This wiki is currently being restored';" >> ../LocalSettings.php

for db in $(docker exec -ti ${INSTANCE_NAME}-mysql mysql -e "SHOW DATABASES" | grep wikitolearn | awk '{ print $2 }') ; do
 echo "Restore "$db
 BACKUP_FILE=$BACKUP_DIR"/"$db
 BACKUP_FILE_STRUCT=$BACKUP_FILE".struct.sql"
 BACKUP_FILE_DATA=$BACKUP_FILE".data.sql"

 if [ -f $BACKUP_FILE_STRUCT ] ; then
  cat $BACKUP_FILE_STRUCT | docker exec -i ${INSTANCE_NAME}-mysql mysql $db
 else
  echo "Missing "$BACKUP_FILE_STRUCT
 fi
 if [ -f $BACKUP_FILE_DATA ] ; then
  cat $BACKUP_FILE_DATA | docker exec -i ${INSTANCE_NAME}-mysql mysql $db
 else
  echo "Missing "$BACKUP_FILE_DATA
 fi
done

rsync --stats -av ${BACKUP_DIR}"/images/" ../mediawiki/images/

sed -i "/\$wgReadOnly = 'This wiki is currently being backuped';/d" ../LocalSettings.php
