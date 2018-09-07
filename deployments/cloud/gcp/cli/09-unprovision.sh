#!/usr/bin/env bash

KUBE_CLUSTER_NAME=${KUBE_CLUSTER_NAME:-exampleapp-kube-cluster}
gcloud container clusters delete ${KUBE_CLUSTER_NAME} --quiet

gsutil rm -r gs://artifacts.$(gcloud config get-value project).appspot.com

CONTAINER_REGISTRY=gcr.io/$(gcloud config get-value project)
for IMAGE in $(gcloud container images list --repository ${CONTAINER_REGISTRY} --format="value(name)"); do
  gcloud container images delete ${IMAGE} --force-delete-tags --quiet
done

for DISK in $(gcloud compute disks list --format="value(name)"); do
    gcloud compute disks delete ${DISK} --quiet
done