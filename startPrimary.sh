#!/bin/bash
imageName=mongo:bitnami-4.4

containerName=mongo1
networkName=$1
dataDir=data/node1
logDir=logs/node1
exposedPort=27017
mongoDefaultPort=27017

echo "Starting ${imageName} as ${containerName} in port ${port}..."
docker run \
  -d \
  --name ${containerName} \
  -v $(pwd)/conf/node/conf:/opt \
  -v $(pwd)/${logDir}:/var/log/mongodb/ \
  --network=$networkName \
  -p $exposedPort:$mongoDefaultPort \
  -e MONGODB_REPLICA_SET_MODE=primary \
  -e MONGODB_ADVERTISED_HOSTNAME=${containerName} \
  -e MONGODB_PORT_NUMBER=${mongoDefaultPort} \
  -e MONGODB_ADVERTISED_PORT_NUMBER=${mongoDefaultPort} \
  -e ALLOW_EMPTY_PASSWORD=yes \
  ${imageName}

# DATA PRESERVATION: 
# Use a mount like this to a local dir to make it preserve data
  # -v $(pwd)/${dataDir}:/data/db \
