#!/usr/bin/env bash
export CONTAINER_REGISTRY=gcr.io/$(gcloud config get-value project)
cat resources/example-app.yml | envsubst > ./output/example-app.yml 
