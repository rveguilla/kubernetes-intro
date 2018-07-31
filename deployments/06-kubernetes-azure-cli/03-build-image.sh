#!/usr/bin/env bash
CONTAINER_REGISTRY=$(az acr show --query loginServer --output tsv)
pushd ../..
  ./build.sh
  docker build --tag ${CONTAINER_REGISTRY}/example-app .
popd
