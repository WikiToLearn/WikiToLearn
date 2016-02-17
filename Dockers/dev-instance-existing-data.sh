#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"

export MATHOID_NUM_WORKERS=1
export W2L_PRODUCTION=0
./run.sh
./use-instance.sh
sleep 1
./fix-hosts.sh
