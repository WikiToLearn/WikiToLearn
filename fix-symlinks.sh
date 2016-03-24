#!/bin/bash

#Refresh symlinks

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

#remove the existing symlinks
rm $CWD/mediawiki/LocalSettings.php
rm $CWD/mediawiki/skins/Neverland
rm -r $CWD/mediawiki/extensions
rm $CWD/mediawiki/favicon.ico

#create symlinks
ln -s ../LocalSettings.php mediawiki/LocalSettings.php
ln -s ../../Neverland mediawiki/skins/Neverland
ln -s ../extensions mediawiki/extensions
ln -s ../favicon.ico mediawiki/favicon.ico



