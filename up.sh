#!/bin/bash
networkName=rs-network

echo "Creating network 'rs-network'..."
docker network create -d bridge $networkName

./startPrimary.sh $networkName

./startArbiter.sh $networkName

./startSecondary.sh $networkName