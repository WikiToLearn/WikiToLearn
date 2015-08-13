#!/bin/bash

docker exec wikifm-websrv sh -c "/var/www/WikiFM/lang-foreach.sh importDump.php /var/www/WikiFM/developer-dump.xml"
