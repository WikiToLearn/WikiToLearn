#!/bin/bash

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

langlist=$(find secrets/ -name *wikitolearn.php -exec basename {} \; | sed 's/wikitolearn.php//g' | grep -v shared)

for lang in $langlist; do

  WIKI="$lang.wikitolearn.org" php $CWD/mediawiki/maintenance/"$@"
  
done;
