#!/usr/bin/env bash
CONTAINER_REGISTRY=gcr.io/$(gcloud config get-value project)
docker push ${CONTAINER_REGISTRY}/example-app
