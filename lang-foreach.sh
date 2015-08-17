#!/bin/bash

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

langlist="it en pool fr es de"

for lang in $langlist; do

  WIKI="$lang.wikitolearn.org" php $CWD/mediawiki/maintenance/"$@"
  
done;
