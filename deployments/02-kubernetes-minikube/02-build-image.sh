#!/usr/bin/env bash
 eval $(minikube docker-env)
pushd ../..
  docker build --tag example-app .
popd
