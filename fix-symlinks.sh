#!/bin/bash

#Refresh symlinks

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

#remove the existing symlinks
test -e $CWD/mediawiki/LocalSettings.php && rm -f $CWD/mediawiki/LocalSettings.php
test -e $CWD/mediawiki/favicon.ico && rm -f $CWD/mediawiki/favicon.ico
rm -fr $CWD/mediawiki/skins
rm -fr $CWD/mediawiki/extensions


#create symlinks
cd $CWD/mediawiki/
ln -s ../LocalSettings.php LocalSettings.php
ln -s ../extensions        extensions
ln -s ../skins             skins
ln -s ../favicon.ico       favicon.ico


