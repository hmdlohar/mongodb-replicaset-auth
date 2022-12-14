#!/usr/bin/env bash

scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 6 tries
TIMEOUT=6
COUNT=0

# Checking if mongo is up
while ! mongo --port 27026 --eval "var rs_cluster=$(cat ${scriptPath}/replication-cluster.json);" $scriptPath/start-replication.js; do 
  ((COUNT++));
  sleep 1; 
  echo " ";
  echo " ### Waiting for Mongo instance 27023 startup... ${COUNT}s"; 
  (($COUNT > $TIMEOUT)) && 
    echo " ### Cannot start replication: Timeout while trying to connect Mongo instance 27023" &&  
    exit 1;
done


