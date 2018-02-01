#!/usr/bin/env bash
pushd ../..
  ./build.sh
  docker build --tag us.gcr.io/${DOCKER_REGISTRY_NAMESPACE}/example-app .
popd
