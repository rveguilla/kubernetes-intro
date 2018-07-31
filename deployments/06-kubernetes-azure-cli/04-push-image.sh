#!/usr/bin/env bash

CONTAINER_REGISTRY=$(az acr show --query loginServer --output tsv)
docker push ${CONTAINER_REGISTRY}/example-app
