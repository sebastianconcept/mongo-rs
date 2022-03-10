#!/bin/bash

imageName=bitnami/mongodb:4.4
networkName=rs-network

echo "Creating network 'rs-network'..."
docker network create -d bridge $networkName

./startPrimary.sh $imageName $networkName

./startArbiter.sh $imageName $networkName

./startSecondary.sh $imageName $networkName