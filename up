#!/bin/bash
networkName=rs-network

echo "Creating network 'rs-network'..."
docker network create -d bridge $networkName

./startMongo 1 $networkName

./startMongo 2 $networkName

./startMongo 3 $networkName
