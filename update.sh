#!/bin/bash


# Update current repository
git pull

# Update all the submodules
git submodule foreach 'git checkout master; git pull || :'

# Pull in newest content (?)

# rm -r mediawiki/extensions
# ln -s extensions mediawiki/extensions

#< git submodules update >
cp LocalSettings.php mediawiki/


