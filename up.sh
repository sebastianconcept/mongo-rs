#!/bin/bash
networkName=rs-network

echo "Creating network 'rs-network'..."
docker network create -d bridge $networkName

./startMongo.sh 1 $networkName

./startMongo.sh 2 $networkName

./startMongo.sh 3 $networkName

docker exec mongo1 /opt/initialize.sh