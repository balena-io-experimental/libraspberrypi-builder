#!/bin/bash

docker build -t libraspberrypi-builder .

rm -rf output
mkdir -p output
docker run --rm --privileged -v `pwd`/output:/output libraspberrypi-builder
