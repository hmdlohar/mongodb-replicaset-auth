#!/usr/bin/env bash

scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo " "
echo " ### Starting replica set cluster..."

mkdir "${scriptPath}"/rs1/db
mkdir "${scriptPath}"/rs2/db
# mkdir "${scriptPath}"/rs3/db

chmod 600 "${scriptPath}"/rs1/mongodb-keyfile
chmod 600 "${scriptPath}"/rs2/mongodb-keyfile
# chmod 600 "${scriptPath}"/rs3/mongodb-keyfile

echo " "
echo " ### Starting replica set: rs1"
cd ${scriptPath}/rs1
mongod --config mongodb.conf --fork

echo " "
echo " ### Starting replica set: rs2"
cd ${scriptPath}/rs2
mongod --config mongodb.conf --fork

# echo " "
# echo " ### Starting replica set: rs3"
# cd ${scriptPath}/rs3
# mongod --config mongodb.conf --fork

echo " "