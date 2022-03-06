#!/bin/bash

echo "Stopping mongo1..."
docker stop mongo1 

echo "Stopping mongo2..."
docker stop mongo2

echo "Stopping mongo3..."
docker stop mongo3

echo "Removing network..."
docker network rm rs-network