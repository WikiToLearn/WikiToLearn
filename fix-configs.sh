#!/bin/bash
# This script must init all required configs and return exit status 0
# if the exit status is not 0 we assume some critical config missing and in this case wtl can be started
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

if [[ ! -d LocalSettings.d/ ]] ; then
    echo "Missing LocalSettings.d/ directory. FATAL"
    exit 1
fi

if [[ ! -f LocalSettings.d/wgSecretKey.php ]] ; then
    WG_SECRET_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)
    cat > LocalSettings.d/wgSecretKey.php << EOL
<?php

\$wgSecretKey = "$WG_SECRET_KEY";

EOL

fi

if [[ ! -f LocalSettings.d/mysql-username-and-password.php ]] ; then
    echo "Missing LocalSettings.d/mysql-username-and-password.php file. FATAL"
    exit 1
fi
