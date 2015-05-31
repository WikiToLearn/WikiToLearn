#!/bin/bash

rm mediawiki/LocalSettings.php
ln -s LocalSettings.php mediawiki/LocalSettings.php

rm mediawiki/skins/Neverland
ln -s Neverland mediawiki/skins/Neverland

rm -r mediawiki/extensions
ln -s extensions mediawiki/extensions


# Update current repository
git pull

# Update all the submodules
git submodule foreach 'git checkout master; git pull || :'

# Pull in newest content (?) XML


# run update.php
php mediawiki/maintainance/update.php

#< git submodules update >
# cp LocalSettings.php mediawiki/




