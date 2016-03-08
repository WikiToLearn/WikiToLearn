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
  for d in  ${WTL_INSTANCE_NAME}-ocg ${WTL_INSTANCE_NAME}-mysql ${WTL_INSTANCE_NAME}-memcached ${WTL_INSTANCE_NAME}-websrv ${WTL_INSTANCE_NAME}-mathoid ${WTL_INSTANCE_NAME}-parsoid
  do
   echo "Deleting "$d
   docker stop $d && docker rm $d
  done
  docker volume rm ${WTL_INSTANCE_NAME}-var-lib-mysql
  docker volume rm ${WTL_INSTANCE_NAME}-var-log-apache2
  rm -f instance_config.conf
 fi
fi
