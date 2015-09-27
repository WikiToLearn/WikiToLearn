#!/bin/bash
if [[ "$TESTING" == "" ]] ; then
 TESTING=1
fi
export BACKUP_ROOT_DIR=/
test -d /root/w2l || git clone https://github.com/WikiToLearn/WikiToLearn.git /root/w2l
cd /root/w2l
git pull --recurse-submodules
git submodule update --recursive
if [[ "$CUR" == "" ]] ; then
 if [[ $TESTING -eq 0 ]] ; then
  CUR=$(git rev-list $(git tag | sort -V | tail -1) | head -n 1)
 else
  CUR=$(git log -n1 | grep commit | awk '{ print $2 }')
 fi
fi
echo "Deploy "$CUR
docker inspect ${CUR}-websrv &> /dev/null
if [[ $? -ne 0 ]] ; then
 test -d /root/WikiToLearn/ || mkdir /root/WikiToLearn/
 rsync -a --delete /root/w2l/ /root/WikiToLearn/$CUR/
 cd /root/WikiToLearn/$CUR
 git checkout $CUR
 cd Dockers
 export INSTANCE_NAME=$CUR
 echo "export INSTANCE_NAME='$CUR'" > instance_name.conf
 chmod +x instance_name.conf
 ./run.sh
 ./fix-hosts.sh
 ./copy-conf-to-websrv.sh
 #./restore.sh /root/CurrentBackup/
 ./docker-init.sh
 ./haproxy-use-instance.sh
 if [[ $TESTING -ne 0 ]] ; then
  ls /root/WikiToLearn/ | grep -v $CUR | while read OLD
  do
   cd /root/WikiToLearn/$OLD/Dockers/
   export INSTANCE_NAME=$OLD
   export I_know_what_I_m_doing=danger
   ./destroy.sh
   cd /root/WikiToLearn/
   rm -Rf /root/WikiToLearn/$OLD/
  done
 fi
fi

