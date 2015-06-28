#!/bin/bash

# NOTE If you add a symlink here, please add it also to init-symlinks.sh

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

cd $CWD;

# get rid of all our symlinks
rm mediawiki/LocalSettings.php
rm mediawiki/skins/Neverland
rm mediawiki/extensions
rm mediawiki/dbconfig
rm mediawiki/favicon.ico
