#!/bin/bash
imageName=mongo:current

containerName=mongo$1
networkName=$2
# dataDir=data/node$1
dataDir=/Volumes/RAMDisk/data/node$1
logDir=logs/node$1

# Will use ports starting from 27017
exposedPort=$((27016 + $1))
mongoDefaultPort=27017

echo "Starting ${imageName} as ${containerName} in port ${port}..."
docker run -d \
  --name ${containerName} \
  -v $(pwd)/conf/node/conf:/opt/mongo/ \
  -v $(pwd)/${logDir}:/var/log/mongodb/ \
  --network=$networkName \
  -p $exposedPort:$mongoDefaultPort \
  ${imageName} \
  /usr/bin/mongod -f /opt/mongo/mongod.conf

# DATA PRESERVATION: 
# Use a mount like this to a local dir to make it preserve data
  # -v $(pwd)/${dataDir}:/data/db \

