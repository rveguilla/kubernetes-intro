#!/usr/bin/env bash
export CONTAINER_REGISTRY=gcr.io/$(gcloud config get-value project)

rm -rf ./output/example-app/
mkdir -p ./output/example-app/

for K8_MANIFEST in $(ls -1 resources/example-app/*.yml); do
    cat ${K8_MANIFEST} | envsubst > ./output/example-app/$(basename ${K8_MANIFEST})
done

