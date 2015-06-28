#!/bin/bash

langlist="it en pool fr es de"

for lang in $langlist; do

  WIKI="$lang.wikifm.org" php mediawiki/maintainance/"$@"
  
done;