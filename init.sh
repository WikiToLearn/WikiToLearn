#!/bin/bash

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

