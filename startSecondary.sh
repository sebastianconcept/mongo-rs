#!/bin/bash
imageName=mongo:current

containerName=mongo3
networkName=$2
dataDir=data/node$1
logDir=logs/node$1
exposedPort=27019
mongoDefaultPort=27017

echo "Starting ${imageName} as ${containerName} in port ${port}..."
docker run \
  -d \
  --name ${containerName} \
  -v $(pwd)/conf/node/conf:/opt/mongo/ \
  -v $(pwd)/${logDir}:/var/log/mongodb/ \
  --network=$networkName \
  -p $exposedPort:$mongoDefaultPort \
  -e MONGODB_REPLICA_SET_MODE=secondary \
  -e MONGODB_ADVERTISED_HOSTNAME=${containerName} \
  -e MONGODB_PORT_NUMBER=${mongoDefaultPort} \
  -e MONGODB_ADVERTISED_PORT_NUMBER=${mongoDefaultPort} \
  -e ALLOW_EMPTY_PASSWORD=yes \
  ${imageName} \
  /opt/bitnami/mongodb/bin/mongod -f /opt/mongo/mongod.conf

# DATA PRESERVATION: 
# Use a mount like this to a local dir to make it preserve data
  # -v $(pwd)/${dataDir}:/data/db \

