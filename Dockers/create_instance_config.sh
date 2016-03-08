#!/bin/bash
if [[ ! -f instance_config.conf ]] ; then
 {
  [[ -z "$WTL_INSTANCE_NAME" ]] && WTL_INSTANCE_NAME=wtl-dev
  echo "export WTL_INSTANCE_NAME=$WTL_INSTANCE_NAME"
  [[ -z "$WTL_BACKUP_ENABLED" ]] && WTL_BACKUP_ENABLED=0
  echo "export WTL_BACKUP_ENABLED=$WTL_BACKUP_ENABLED"
  [[ -z "$WTL_BACKUP_PATH" ]] && WTL_BACKUP_PATH=""
  echo "export WTL_BACKUP_PATH=$WTL_BACKUP_PATH"

  [[ -z "$WTL_RELAY_HOST" ]] && WTL_RELAY_HOST="mail"
  echo "export WTL_RELAY_HOST=$WTL_RELAY_HOST"

  [[ -z "$WTL_SKIP_OCG_DOCKER" ]] && WTL_SKIP_OCG_DOCKER="0"
  echo "export WTL_SKIP_OCG_DOCKER=$WTL_SKIP_OCG_DOCKER"

  echo ". ../docker-images.conf"
 } > instance_config.conf
 echo
 echo "Created default instance_config.conf file"
 echo
 sleep 1
 echo
fi
chmod +x instance_config.conf
