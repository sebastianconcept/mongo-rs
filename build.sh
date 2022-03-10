#!/bin/bash

echo "Building..."

docker build \
  -t mongo:current \
  $(pwd)/conf/
