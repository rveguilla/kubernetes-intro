#!/usr/bin/env bash

REGISTRY_ID=$(aws ecr describe-repositories --repository-names example-app --query "repositories[0].registryId" --output text)
export CONTAINER_REGISTRY=${REGISTRY_ID}.dkr.ecr.us-east-1.amazonaws.com

rm -rf ./output/example-app/
mkdir -p ./output/example-app/

for K8_MANIFEST in $(ls -1 resources/example-app/*.yml); do
    cat ${K8_MANIFEST} | envsubst > ./output/example-app/$(basename ${K8_MANIFEST})
done

