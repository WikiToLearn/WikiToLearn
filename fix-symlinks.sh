#!/bin/bash

#Refresh symlinks

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

#remove the existing symlinks
test -f $CWD/mediawiki/LocalSettings.php && rm $CWD/mediawiki/LocalSettings.php
test -f $CWD/mediawiki/skins/Neverland && rm $CWD/mediawiki/skins/Neverland
test -f $CWD/mediawiki/favicon.ico && rm $CWD/mediawiki/favicon.ico
rm -r $CWD/mediawiki/extensions


#create symlinks
ln -s ../LocalSettings.php mediawiki/LocalSettings.php
ln -s ../../Neverland mediawiki/skins/Neverland
ln -s ../extensions mediawiki/extensions
ln -s ../favicon.ico mediawiki/favicon.ico



