#!/bin/bash
imageName=$1

containerName=mongo2
networkName=$2
dataDir=data/node2
logDir=logs/node2
exposedPort=27018
mongoDefaultPort=27017

echo "Starting ${imageName} as ${containerName} in port ${port}..."
docker run \
  -d \
  --name ${containerName} \
  -v $(pwd)/${logDir}:/var/log/mongodb/ \
  --network=$networkName \
  -p $exposedPort:$mongoDefaultPort \
  -e MONGODB_REPLICA_SET_MODE=arbiter \
  -e MONGODB_ADVERTISED_HOSTNAME=${containerName} \
  -e MONGODB_PORT_NUMBER=${mongoDefaultPort} \
  -e MONGODB_ADVERTISED_PORT_NUMBER=${mongoDefaultPort} \
  -e ALLOW_EMPTY_PASSWORD=yes \
  -e MONGODB_INITIAL_PRIMARY_HOST=mongo1 \
  ${imageName}
  
  # -v $(pwd)/conf/node/conf:/opt/mongo/ \

# DATA PRESERVATION: 
# Use a mount like this to a local dir to make it preserve data
  # -v $(pwd)/${dataDir}:/data/db \

