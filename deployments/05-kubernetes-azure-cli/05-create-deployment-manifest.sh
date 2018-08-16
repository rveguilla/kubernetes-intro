#!/usr/bin/env bash
export CONTAINER_REGISTRY=$(az acr show --query loginServer --output tsv)
cat resources/example-app.yml | envsubst > ./output/example-app.yml 
