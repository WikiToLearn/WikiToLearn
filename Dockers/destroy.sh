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

REPLY=""
REPLY_DO="yY"
# if you set I_know_what_I_m_doing=danger it skip asking confermation

if [[ "$I_know_what_I_m_doing" != "danger" ]]
then
 if [[ $(($RANDOM % 2 )) -eq 0 ]] ; then
  read -p "Are you sure? This operation can't be undone (y/n) " -n 1 -r
  echo
 else
  read -p "You want quit? (y/n) " -n 1 -r
  echo
  REPLY_DO="nN"
 fi
else
 REPLY="y"
fi

if [[ $REPLY =~ ^[$REPLY_DO]$ ]]
then
 REPLY_DO="nN"
 if [[ "$I_know_what_I_m_doing" != "danger" ]]
 then
  if [[ $(($RANDOM % 2 )) -eq 0 ]] ; then
   read -p "You want quit the process? (y/n) " -n 1 -r
   echo
  else
   read -p "You want continue the process? (y/n) " -n 1 -r
   echo
   REPLY_DO="yY"
  fi
 else
  REPLY="n"
 fi

 if [[ $REPLY =~ ^[$REPLY_DO]$ ]]
 then
  echo "ok, I'm doing..."
  for d in  ${W2L_INSTANCE_NAME}-ocg ${W2L_INSTANCE_NAME}-mysql ${W2L_INSTANCE_NAME}-memcached ${W2L_INSTANCE_NAME}-websrv
  do
   echo "Deleting "$d
   docker stop $d && docker rm $d
  done
  rm $W2L_DOCKER_WEBSRV_LOG_PATH -Rf
  rm $W2L_DOCKER_MYSQL_DATA_PATH -Rf
  rm -f instance_config.conf
 fi
fi
