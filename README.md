# Dockerized Mongo Replica Set

This code setups a local `Docker` based `MongoDB` replica set using the official docker image from mongo.

## Run

For example, the current version here will start a MongoDB 4.0.10 replica set:

1. `./build.sh 4010`
2. `./up.sh`

## Stop

`./down.sh`

## Replication

The replica set is initialized with the name `rs1` by running `initialize.sh` in `mongo1` at the end of the `up.sh` script. 

Note that `initializeReplicaSet.js` is using the default mongodb port and the containers names in the docker network to setup its memebers. Also note that, as this aims to be a helper for development and testing setups, at the end of the initialization, the replica set is set to log profiling in level 2:

`db.setProfilingLevel(2);`

## Preserve data
For data preservation, edit `startMongo.sh` and add a line to mount a directory from the host. For example to have every MongoDB node database written under `./data/`, mount a volume like:

`-v $(pwd)/${dataDir}:/data/db` 


## Logs
MongoDB logs are sent to:
-  `./logs/node1/mongod.log`
-  `./logs/node2/mongod.log`
-  `./logs/node3/mongod.log`


## Change MongoDB version

To create this replica set using a different MongoDB version proceed to:

1. Edit `./conf/Dockerfile` and change the tag `FROM mongo:4.0.10` to the version you want from the [MongoDB images](https://hub.docker.com/_/mongo/?tab=tags).  For example `mongo:5.0.6`
2. Run `./build.sh <yourLocalMongoTag>`. For example: `./build.sh mongo:5.0.6`
3. Edit `./startMongo.sh` to change `imageName=mongo:4010` with `imageName=mongo:<yourLocalMongoTag>`. For example `mongo:506`
4. Run `./up.sh`