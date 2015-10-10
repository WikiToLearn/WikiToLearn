#!/bin/bash

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

cd $CWD

langlist=$(find secrets/ -name *wikitolearn.php -exec basename {} \; | sed 's/wikitolearn.php//g' | grep -v shared)

for lang in $langlist; do
  echo "Current lang: "$lang
  WIKI="$lang.wikitolearn.org" php $CWD/mediawiki/maintenance/"$@"
  
done;
