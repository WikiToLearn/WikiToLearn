#!/bin/bash

if [[ "$langs" != "" ]] ; then
 {
  echo '"use strict";'
  echo
  echo "exports.setup = function( parsoidConfig ) {"

  for lang in $langs ; do
   echo "        parsoidConfig.setInterwiki( '"$lang"wikitolearn', 'http://"$lang".wikitolearn.org/api.php' );"
  done

  echo "        parsoidConfig.debug = true;"
  echo "        parsoidConfig.useSelser = true;"
  echo "        parsoidConfig.allowCORS = '*';"
  echo "        parsoidConfig.serverPort = 8000;"
  echo "};"
 } > /etc/mediawiki/parsoid/settings.js
fi

/etc/init.d/parsoid start
/etc/init.d/redis-server start
cd /var/lib/ocg/mw-ocg-service/
./mw-ocg-service.js -c localsettings.js
