#!/bin/bash
cd "$(dirname "$(readlink "$0" || printf %s "$0")")"
./run.sh
./fix-hosts.sh
export W2L_INIT_DB=1
./init-docker.sh
./use-instance.sh
