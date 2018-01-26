#!/usr/bin/env bash
pushd ../..
  ./build.sh
  docker build --tag ${DOCKER_REGISTRY_NAMESPACE}/example-app .
popd
