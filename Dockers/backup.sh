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
 INSTANCE_NAME="wikitolearn"
fi

docker inspect ${INSTANCE_NAME}-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing mysql for inscance "${INSTANCE_NAME}-
 exit 1
fi

{
cat configs/my.cnf | docker exec -i ${INSTANCE_NAME}-mysql tee /root/.my.cnf
} > /dev/null

BACKUP_DIR="backups/"$(date +'%Y_%m_%d__%H_%M_%S')

test -d $BACKUP_DIR || mkdir $BACKUP_DIR

rsync --stats -av ../mediawiki/images/ ${BACKUP_DIR}"/images"

echo "\$wgReadOnly = 'This wiki is currently being backuped';" >> ../LocalSettings.php

for db in $(docker exec -ti ${INSTANCE_NAME}-mysql mysql -e "SHOW DATABASES" | grep wikitolearn | awk '{ print $2 }') ; do
 echo "Backup "$db
 BACKUP_FILE=$BACKUP_DIR"/"$db
 BACKUP_FILE_STRUCT=$BACKUP_FILE".struct.sql"
 BACKUP_FILE_DATA=$BACKUP_FILE".data.sql"

 docker exec -ti ${INSTANCE_NAME}-mysql mysqldump --skip-add-drop-table --skip-comments -d $db > $BACKUP_FILE_STRUCT
 sed -i 's/CREATE TABLE/CREATE TABLE IF NOT EXISTS/g' $BACKUP_FILE_STRUCT

 docker exec -ti ${INSTANCE_NAME}-mysql mysqldump --no-create-info $db > $BACKUP_FILE_DATA
done

rsync --stats -av ../mediawiki/images/ ${BACKUP_DIR}"/images"

sed -i "/\$wgReadOnly = 'This wiki is currently being backuped';/d" ../LocalSettings.php
