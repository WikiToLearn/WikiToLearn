#!/bin/bash

## DANGEROUS SCRIPT

echo "This is dangerous! please install some security checks"

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

# $CWD/mediawiki/maintenance/tables.sql

# $CWD/lang-foreach.sh sql.php --conf $CWD/mediawiki/LocalSettings.php $CWD/mediawiki/maintenance/tables.sql
$CWD/lang-foreach.sh sql.php --debug --conf $CWD/mediawiki/LocalSettings.php $CWD/empty-wikifm.sql

# For every language, update the database
$CWD/lang-foreach.sh update.php --conf=$CWD/mediawiki/LocalSettings.php --quick --doShared

# Create user

