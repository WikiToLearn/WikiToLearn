#!/bin/bash
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

if [[ "$WTL_BACKUP_ENABLED" != "1" ]] ; then
 echo "Backup disabiled"
 exit 1
fi

if [[ "$WTL_BACKUP_PATH" == "" ]] ; then
 echo "Missing WTL_BACKUP_PATH"
 exit 1
fi

if [[ ! -d "$WTL_BACKUP_PATH" ]] ; then
 echo "$WTL_BACKUP_PATH i not a directory"
 exit 1
fi

which rsync &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing rsync command"
 exit 1
fi

docker inspect ${WTL_INSTANCE_NAME}-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing mysql for inscance "${WTL_INSTANCE_NAME}
 exit 1
fi

{
cat configs/my.cnf | docker exec -i ${WTL_INSTANCE_NAME}-mysql tee /root/.my.cnf
} > /dev/null

BACKUP_DIR=$WTL_BACKUP_PATH"/"$(date +'%Y_%m_%d__%H_%M_%S')

test -d $BACKUP_DIR || mkdir $BACKUP_DIR

rsync --stats -av ../mediawiki/images/ ${BACKUP_DIR}"/images/"

WIKI_RO_MSG="\$wgReadOnly = 'This wiki is currently being backed up';"

echo $WIKI_RO_MSG >> ../LocalSettings.php

for db in $(docker exec -ti ${WTL_INSTANCE_NAME}-mysql mysql -e "SHOW DATABASES" | grep wikitolearn | awk '{ print $2 }') ; do
 echo "Backup "$db
 BACKUP_FILE=$BACKUP_DIR"/"$db
 BACKUP_FILE_STRUCT=$BACKUP_FILE".struct.sql"
 BACKUP_FILE_DATA=$BACKUP_FILE".data.sql"

 docker exec -ti ${WTL_INSTANCE_NAME}-mysql mysqldump --skip-add-drop-table --skip-comments -d $db > $BACKUP_FILE_STRUCT
 sed -i 's/CREATE TABLE/CREATE TABLE IF NOT EXISTS/g' $BACKUP_FILE_STRUCT

 docker exec -ti ${WTL_INSTANCE_NAME}-mysql mysqldump --no-create-info $db > $BACKUP_FILE_DATA
done

rsync --stats -av ../mediawiki/images/ ${BACKUP_DIR}"/images/"

sed -i "/$WIKI_RO_MSG/d" ../LocalSettings.php
