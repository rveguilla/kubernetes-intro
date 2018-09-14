#!/usr/bin/env bash

if [ -z "${GCLOUD_PROJECT}" ]; then
    echo "Error: GCLOUD_PROJECT environment variable required."
    exit -1
fi


KUBE_CLUSTER_NAME=${KUBE_CLUSTER_NAME:-exampleapp-kube-cluster}
REGION=${REGION:-us-central1}
ZONE=${REGION}-a
NODE_COUNT=${NODE_COUNT:-3}

gcloud config set project ${GCLOUD_PROJECT}
gcloud config set compute/region ${REGION}
gcloud config set compute/zone ${ZONE}
gcloud services enable container.googleapis.com compute.googleapis.com
gcloud container clusters create ${KUBE_CLUSTER_NAME} --num-nodes=${NODE_COUNT}
