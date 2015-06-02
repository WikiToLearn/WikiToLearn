First time checkout
===================

Make sure you create an empty MySQL database and a user with sufficient permissions to operate on it.
The following script

    ./init.sh <database name> <database user> <database user password>
    
will take care of importing an empty WikiFM in your empty MySQL database, and will create a configuration file that will allow MediaWiki to connect to the database.

It will also set-up the necessary symlinks to


Importing some content
======================

Import the XML Dump

Updating the checkout
=====================

To update the checkout you should not run `git pull` but instead

    ./update.sh
    
which will take care of running all the necessary updates to the code, updating the database and so on...


Updating to a certain release
=============================
Last version

    git tag -l |grep -v wmf |grep -v test|sort -V|tail -n1
    git checkout $(git tag -l |grep -v wmf |grep -v test|sort -V|tail -n1)

Make sure all extensions are on the right branch
    
    export MW_RELEASE="1_25"
    for d in $(ls extensions/); do cd $d; git fetch; git checkout remotes/origin/REL$MW_RELEASE; cd ../..; done 

