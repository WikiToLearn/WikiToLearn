#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ ! -f ./instance_config.conf ]] ; then
 echo "Missing ./instance_config.conf file"
 exit 1
fi

. ./instance_config.conf

if [[ "$W2L_INSTANCE_NAME" == "" ]] ; then
 echo "Missing key env variabile W2L_INSTANCE_NAME"
 exit 1
fi

if [[ "$W2L_BACKUP_ENABLED" != "1" ]] ; then
 echo "Backup disabiled"
 exit 1
fi

if [[ "$W2L_BACKUP_PATH" == "" ]] ; then
 echo "Missing W2L_BACKUP_PATH"
 exit 1
fi

if [[ ! -d "$W2L_BACKUP_PATH" ]] ; then
 echo "$W2L_BACKUP_PATH i not a directory"
 exit 1
fi

which rsync &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing rsync command"
 exit 1
fi

docker inspect ${W2L_INSTANCE_NAME}-mysql &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "Missing mysql for inscance "${W2L_INSTANCE_NAME}-
 exit 1
fi

{
cat configs/my.cnf | docker exec -i ${W2L_INSTANCE_NAME}-mysql tee /root/.my.cnf
} > /dev/null

BACKUP_DIR=$1

if [ ! -d "$BACKUP_DIR" ] ; then
 echo "Missing "$BACKUP_DIR
 exit 1
fi

WIKI_RO_MSG="\$wgReadOnly = 'This wiki is currently being restored';"

echo $WIKI_RO_MSG >> ../LocalSettings.php


for db in $(docker exec -ti ${W2L_INSTANCE_NAME}-mysql mysql -e "SHOW DATABASES" | grep wikitolearn | awk '{ print $2 }') ; do
 echo "Restore "$db
 BACKUP_FILE="${BACKUP_DIR}/"$db
 BACKUP_FILE_STRUCT="${BACKUP_FILE}.struct.sql"
 BACKUP_FILE_DATA="${BACKUP_FILE}.data.sql"

 if [ -f "$BACKUP_FILE_STRUCT" ] ; then
  cat "$BACKUP_FILE_STRUCT" | docker exec -i ${W2L_INSTANCE_NAME}-mysql mysql $db
 else
  echo "Missing $BACKUP_FILE_STRUCT"
 fi
 if [ -f "$BACKUP_FILE_DATA" ] ; then
  cat "$BACKUP_FILE_DATA" | docker exec -i ${W2L_INSTANCE_NAME}-mysql mysql $db
 else
  echo "Missing $BACKUP_FILE_DATA"
 fi
done

rsync --stats -av "${BACKUP_DIR}/images/" ../mediawiki/images/

sed -i "/$WIKI_RO_MSG/d" ../LocalSettings.php
