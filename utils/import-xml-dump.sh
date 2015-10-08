#!/bin/bash

docker exec w2l-dev-websrv sh -c "/var/www/WikiToLearn/lang-foreach.sh importDump.php /var/www/WikiToLearn/developer-dump.xml"
