#!/usr/bin/env bash

docker build --tag us.gcr.io/${DOCKER_REGISTRY_NAMESPACE}/example-app ../..
