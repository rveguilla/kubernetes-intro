#!/usr/bin/env bash
export GCR_key=$(cat resources/account.json)
docker login -u _json_key -p "${GCR_KEY}" https://us.gcr.io
docker push us.gcr.io/${DOCKER_REGISTRY_NAMESPACE}/example-app
