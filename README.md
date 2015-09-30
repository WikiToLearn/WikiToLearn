# Hacking Notes

## If you add a new language

* Add your language to lang-foreach.sh
* Add your language to LocalSettings.php
* Add the new language to the CREATE DATABASE in run.sh
* Add the new apache alias in the websrv repository and build new docker

First time checkout
===================

Our environment is based on dockers
You must install docker ( https://docs.docker.com/installation/ )
When you have running docker instance you can start the WikiToLearn env by executing the script

    ./run.sh
    
This pull dockers from internet and execute everything is required
The second script is

    ./fix-hosts.sh

to make all dockers able to talk each other ( it is necessary for a docker link limitation)

If you have a backup directory of wiki system you can now restore it whit

    ./restore.sh <full path of backup>
    
and then set this env variabile:

    export W2L_INIT_DB=0

else you have to set it in this way

    export W2L_INIT_DB=1
    
This variabile is required by the next script to bootstrap the database
Now run

    ./init-docker.sh
    
Last command is:

    ./use-instance.sh
    
This create an haproxy docker to allow everything to work properly
    

Make a backup
======================

To create a backup you must to modify instance_config.conf (create by run.sh script)
And set

    export W2L_BACKUP_ENABLED=1
    
end 

    export W2L_BACKUP_PATH=<my absolute backup path>
    
and then run

    ./backup.sh
    
That's all, I hope

Happy Wiki!

