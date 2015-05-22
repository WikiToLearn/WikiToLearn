#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <database name> <database user> <database user password>"
  exit 1
fi

echo "\$wgSitename      = 'WikiFM - Development version';
\$wgLanguageCode     = 'en';
\$wgDBuser           = '$2';
\$wgDBname           = '$1';
\$wgDBpassword       = '$3';" > DatabaseSettings.php

mysql --user=$2 --password=$3 --database=$1 < empty-wikifm.sql

ln -s LocalSettings.php mediawiki/LocalSettings.php
rm -r mediawiki/extensions
ln -s extensions mediawiki/extensions
