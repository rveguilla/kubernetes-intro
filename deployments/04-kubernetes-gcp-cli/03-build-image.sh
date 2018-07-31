#!/usr/bin/env bash
CONTAINER_REGISTRY=gcr.io/$(gcloud config get-value project)
pushd ../..
  ./build.sh
  docker build --tag ${CONTAINER_REGISTRY}/example-app .
popd
