#!/bin/bash
# imageName=mongo:4.0.10
imageName=mongo:4010

containerName=mongo$1
networkName=$2
dataDir=data/node$1
port=$((27016 + $1))

# DOCKER_MEMORY_LIMIT=1g

echo "Starting ${imageName} as ${containerName} in port ${port}..."

docker run -d --rm \
  --name ${containerName} \
  -v $(pwd)/conf/node/conf:/opt/mongo/ \
  --network=$networkName \
  -p $port:27017 \
  ${imageName} \
  /usr/bin/mongod -f /opt/mongo/mongod.conf
  # bash

