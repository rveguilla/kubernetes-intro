#!/usr/bin/env bash
CONTAINER_REGISTRY=gcr.io/$(gcloud config get-value project)
pushd ../../../..
  docker build --tag ${CONTAINER_REGISTRY}/example-app .
popd
