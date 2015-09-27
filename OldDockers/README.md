# WikiFM-Docker

Those files contains basic instructions to deploy working environment for WikiFM

* Start
./run.sh <wikifm clone path>
./copy-conf-to-websrv.sh
./fix-hosts.sh
./docker-init.sh

* Destroy
./destroy.sh

###### To add a language you must to add in "./run.sh" in line 83 a line like
```
echo "CREATE DATABASE IF NOT EXISTS [langcode]wikifm;"
```
