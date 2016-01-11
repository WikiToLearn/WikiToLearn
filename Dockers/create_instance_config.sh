#!/bin/bash
if [[ ! -f instance_config.conf ]] ; then
 {
  [[ -z "$W2L_INSTANCE_NAME" ]] && W2L_INSTANCE_NAME=w2l-dev
  echo "export W2L_INSTANCE_NAME=$W2L_INSTANCE_NAME"
  [[ -z "$W2L_BACKUP_ENABLED" ]] && W2L_BACKUP_ENABLED=0
  echo "export W2L_BACKUP_ENABLED=$W2L_BACKUP_ENABLED"
  [[ -z "$W2L_BACKUP_PATH" ]] && W2L_BACKUP_PATH=""
  echo "export W2L_BACKUP_PATH=$W2L_BACKUP_PATH"
  [[ -z "$W2L_DOCKER_MYSQL_DATA_PATH" ]] && W2L_DOCKER_MYSQL_DATA_PATH=$(pwd)"/mysql-data/"
  echo "export W2L_DOCKER_MYSQL_DATA_PATH=$W2L_DOCKER_MYSQL_DATA_PATH"
  [[ -z "$W2L_DOCKER_WEBSRV_LOG_PATH" ]] && W2L_DOCKER_WEBSRV_LOG_PATH=$(pwd)"/websrv-log/"
  echo "export W2L_DOCKER_WEBSRV_LOG_PATH=$W2L_DOCKER_WEBSRV_LOG_PATH"
  [[ -z "$W2L_DOCKER_MOUNT_DIRS" ]] && W2L_DOCKER_MOUNT_DIRS=0
  echo "export W2L_DOCKER_MOUNT_DIRS=$W2L_DOCKER_MOUNT_DIRS"

  [[ -z "$W2L_RELAY_HOST" ]] && W2L_RELAY_HOST="mail"
  echo "export W2L_RELAY_HOST=$W2L_RELAY_HOST"

  [[ -z "$W2L_SKIP_OCG_DOCKER" ]] && W2L_SKIP_OCG_DOCKER="0"
  echo "export W2L_SKIP_OCG_DOCKER=$W2L_SKIP_OCG_DOCKER"

  echo "export W2L_DOCKER_MYSQL=mysql:5.6"
  echo "export W2L_DOCKER_MEMCACHED=memcached:1.4.24"
  echo "export W2L_DOCKER_OCG=wikitolearn/ocg:0.7.1"
  echo "export W2L_DOCKER_WEBSRV=wikitolearn/websrv:0.11"
  echo "export W2L_DOCKER_HAPROXY=wikitolearn/haproxy:0.5"
 } > instance_config.conf
 echo
 echo "Created default instance_config.conf file"
 echo
 sleep 1
 echo
fi
chmod +x instance_config.conf
