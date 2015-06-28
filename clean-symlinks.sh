#!/bin/bash

# NOTE If you add a symlink here, please add it also to init-symlinks.sh

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

# get rid of all our symlinks
rm $CWD/mediawiki/LocalSettings.php
rm $CWD/mediawiki/skins/Neverland
rm -r $CWD/mediawiki/extensions
rm $CWD/mediawiki/favicon.ico
