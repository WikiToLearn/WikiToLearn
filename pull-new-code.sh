#!/bin/bash

CWD="$( 
  cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
  pwd -P 
)"

cd $CWD;

./clean-symlinks.sh

# Let's avoid conflicts
cd mediawiki; git reset --hard; cd -

# Update current repository
git pull

# Update all the submodules
git submodule foreach 'git checkout master; git pull || :'

./init-symlinks.sh

# Check if we need new dependencies
cd mediawiki; composer install; cd -

# compile last textvccheck, if needed
cd mediawiki/extensions/Math/texvccheck/; make; cd -

# run update.php
php mediawiki/maintenance/update.php





