#!/bin/bash

if [[ ! -f init.sh ]] ; then
  echo "You are not running the init script from the WikiFM main directory. The installation script relies heavily on this. Please cd to the cloned directory and re-launch init.sh from there."
  exit 1
fi
if [[ ! -f update.sh ]] ; then
  echo "You are not running the init script from the WikiFM main directory. The installation script relies heavily on this. Please cd to the cloned directory and re-launch init.sh from there."
  exit 1
fi

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <database name> <database user> <database user password>"
  exit 1
fi

if [ ! -e DatabaseSettings.php ]; then
    echo "<?php
    \$wgSitename      = 'WikiFM - Development version';
    \$wgLanguageCode     = 'en';
    \$wgDBuser           = '$2';
    \$wgDBname           = '$1';
    \$wgDBpassword       = '$3';
    ?>" > DatabaseSettings.php
fi

mysql --user=$2 --password=$3 --database=$1 < empty-wikifm.sql

git submodule update --init --recursive

./update.sh

