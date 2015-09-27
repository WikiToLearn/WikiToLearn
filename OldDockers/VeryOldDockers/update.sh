#!/bin/bash

# Update current repository
git pull

# Update all the submodules
git submodule foreach 'git checkout master; git pull || :'

# Pull in newest content (?) XML

cd mediawiki/
git checkout 1.25.1
cd ..

pwd

#rm mediawiki/LocalSettings.php
sed -i "s/\/srv\/www\/production\/mediawiki-current\//\/var\/www\/WikiFM\/mediawiki\//g" LocalSettings.php
cat LocalSettings.php > mediawiki/LocalSettings.php

rm mediawiki/skins/Neverland
cd mediawiki/skins/
ln -s ../../Neverland Neverland
cd ../..

rm -r mediawiki/extensions
cd mediawiki/
ln -s ../extensions extensions
cd ..

cd mediawiki
composer install
cd ..

cd mediawiki/extensions/Math/texvccheck/
make
cd -

# run update.php
php mediawiki/maintenance/update.php

#< git submodules update >
# cp LocalSettings.php mediawiki/




