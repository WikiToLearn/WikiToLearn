#!/bin/bash


# Update current repository
git pull

# Update all the submodules
git submodule foreach 'git checkout master; git pull || :'

# Pull in newest content (?) XML

rm -r mediawiki/extensions
ln -s extensions mediawiki/extensions

# run update.php
php mediawiki/maintainance/update.php

#< git submodules update >
# cp LocalSettings.php mediawiki/


