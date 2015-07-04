#!/bin/bash

# This file will be run exactly one time after the docker containers
# are up and running.

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

cd $CWD;

if [[ ! -e secrets/itwikifm.php ]]; then
    echo "I can't find secrets!!! (at least, secrets/itwikifm.php)"
    echo "Please copy the secrets in $CWD/secrets and try again."
    exit 1;
fi;

# if [[ -e init.lockfile ]]; then
#     echo "You have already called this script."
#     echo "If you really want to init again, please remove $CWD/init.lockfile"
#     exit 1;
# else
#     touch $CWD/init.lockfile
# fi;

$CWD/init-symlinks.sh

cd $CWD/mediawiki/extensions/Math/texvccheck/; make; cd -
cd $CWD/mediawiki; composer install; cd -;

$CWD/lang-foreach.sh sql.php --debug --conf $CWD/mediawiki/LocalSettings.php $CWD/empty-wikifm.sql
# For every language, update the database
$CWD/lang-foreach.sh update.php --conf=$CWD/mediawiki/LocalSettings.php --quick --doShared

