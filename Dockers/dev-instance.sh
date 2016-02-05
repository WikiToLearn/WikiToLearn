#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

which git &> /dev/null
if [[ $? -ne 0 ]] ; then
 echo "You haven't git, this is a problem. You must install it before continue"
 exit 1
fi

#curbranch=$(git name-rev --name-only HEAD)
#if [[ "$curbranch" != "develop" ]] ; then
# if [[ "$curbranch" != "hotfix" ]] ; then
#  echo "You aren't in 'develop' branch, this is a problem. You must 'git checkout develop' or 'git checkout hotfix'"
#  exit 1
# fi
#fi
echo "Ok, starting..."

export W2L_PRODUCTION=0
./run.sh
./use-instance.sh
sleep 1
./fix-hosts.sh
export W2L_INIT_DB=1
./init-docker.sh
#fix ocg service binding
./fix-hosts-tuttorotto.biz.sh