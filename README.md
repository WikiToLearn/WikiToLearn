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

