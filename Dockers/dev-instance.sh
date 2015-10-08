#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
./run.sh
./use-instance.sh
sleep 1
./fix-hosts.sh
export W2L_INIT_DB=1
./init-docker.sh
