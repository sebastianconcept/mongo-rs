#!/bin/bash

echo "Stopping mongo1..."
docker stop mongo1 | xargs docker rm

echo "Stopping mongo2..."
docker stop mongo2 | xargs docker rm

echo "Stopping mongo3..."
docker stop mongo3 | xargs docker rm

echo "Removing network..."
docker network rm rs-network