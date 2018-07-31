#!/usr/bin/env bash

gcloud projects delete $(gcloud config get-value project)  --quiet

CONTAINER_REGISTRY=gcr.io/$(gcloud config get-value project)
for IMAGE in $(gcloud container images list --repository ${CONTAINER_REGISTRY} --format="value(name)"); do 
  gcloud container images delete $IMAGE --force-delete-tags --quiet
done

