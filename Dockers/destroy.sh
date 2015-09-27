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

# if you set I_know_what_I_m_doing=danger it skip asking confermation

if [[ "$I_know_what_I_m_doing" != "danger" ]]
then
 read -p "Are you sure? This operation can't be undone (y/n) " -n 1 -r
 echo
else
 REPLY="y"
fi

if [[ $REPLY =~ ^[Yy]$ ]]
then
 if [[ "$I_know_what_I_m_doing" != "danger" ]]
 then
  read -p "You want quit the process? (y/n) " -n 1 -r
  echo
 else
  REPLY="n"
 fi

 if [[ $REPLY =~ ^[Nn]$ ]]
 then
  echo "ok, I'm doing..."
  for d in  ${W2L_INSTANCE_NAME}-ocg ${W2L_INSTANCE_NAME}-mysql ${W2L_INSTANCE_NAME}-mailsrv ${W2L_INSTANCE_NAME}-memcached ${W2L_INSTANCE_NAME}-websrv
  do
   echo "Deleting "$d
   docker stop $d && docker rm $d
  done
 fi
fi
