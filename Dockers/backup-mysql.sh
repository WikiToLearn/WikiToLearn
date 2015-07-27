#!/bin/bash
{
cat configs/my.cnf | docker exec -i wikifm-mysql tee /root/.my.cnf
} > /dev/null

BACKUP_DIR="backups/"$(date +'%Y_%m_%d__%H_%M_%S')

test -d $BACKUP_DIR || mkdir $BACKUP_DIR

for db in $(docker exec -ti wikifm-mysql mysql -e "SHOW DATABASES" | grep wikifm | awk '{ print $2 }') ; do
 BACKUP_FILE=$BACKUP_DIR"/"$db
 BACKUP_FILE_STRUCT=$BACKUP_FILE".struct.sql"
 BACKUP_FILE_DATA=$BACKUP_FILE".data.sql"

 docker exec -ti wikifm-mysql mysqldump --skip-add-drop-table --skip-comments -d $db > $BACKUP_FILE_STRUCT
 sed -i 's/CREATE TABLE/CREATE TABLE IF NOT EXISTS/g' $BACKUP_FILE_STRUCT

 docker exec -ti wikifm-mysql mysqldump --no-create-info $db > $BACKUP_FILE_DATA
done
