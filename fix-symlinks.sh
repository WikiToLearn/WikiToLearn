#!/bin/bash

#Refresh symlinks

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

#remove the existing symlinks
test -e $CWD/mediawiki/LocalSettings.php && rm -f $CWD/mediawiki/LocalSettings.php
test -e $CWD/mediawiki/skins/Neverland && rm -f $CWD/mediawiki/skins/Neverland
test -e $CWD/mediawiki/favicon.ico && rm -f $CWD/mediawiki/favicon.ico
rm -fr $CWD/mediawiki/extensions


#create symlinks
ln -s ../LocalSettings.php mediawiki/LocalSettings.php
ln -s ../../Neverland mediawiki/skins/Neverland
ln -s ../extensions mediawiki/extensions
ln -s ../favicon.ico mediawiki/favicon.ico



