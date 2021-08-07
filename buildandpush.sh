#!/bin/sh
IMAGE_NAME="parada1104/buiaco-prod"
BUILD_TARGET="prod-build"
docker build -t $IMAGE_NAME . --target $BUILD_TARGET
docker push $IMAGE_NAME