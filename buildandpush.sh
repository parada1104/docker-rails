#!/bin/sh
IMAGE_NAME="YOUR_IMAGE_TAG"
BUILD_TARGET="YOUR_TARGET (dev-build/prod-build)"
docker build -t $IMAGE_NAME . --target $BUILD_TARGET
docker push $IMAGE_NAME
