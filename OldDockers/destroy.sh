#!/bin/bash

cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ -f instance_name.conf ]] ; then
 . ./instance_name.conf
fi

if [[ "$INSTANCE_NAME" == "" ]] ; then
 INSTANCE_NAME="wikitolearn-dev"
fi

REPLY=""
REPLY="y"

# if you set I_know_what_I_m_doing=danger it skip asking confermation

if [[ "$I_know_what_I_m_doing" != "danger" ]]
then
 read -p "Are you sure? This operation can't be undone (y/n) " -n 1 -r
 echo
fi

if [[ $REPLY =~ ^[Yy]$ ]]
then
 if [[ "$I_know_what_I_m_doing" != "danger" ]]
 then
  read -p "Are you VERY sure? This operation can't be undone (y/n) " -n 1 -r
  echo
 fi

 if [[ $REPLY =~ ^[Yy]$ ]]
 then
  echo "ok, I'm doing..."
  for d in  ${INSTANCE_NAME}-ocg ${INSTANCE_NAME}-mysql ${INSTANCE_NAME}-mailsrv ${INSTANCE_NAME}-memcached ${INSTANCE_NAME}-websrv
  do
   echo "Deleting "$d
   docker stop $d && docker rm $d
  done
 fi
fi
