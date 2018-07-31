#!/usr/bin/env bash

BILLING_ACCOUNT=$(gcloud alpha billing accounts list --filter="open = true" --format "value(name)")

if [ -z "${BILLING_ACCOUNT}" ]; then
    echo "Error: could not find a billing account. Please got to https://console.cloud.google.com/billing and configure a billing account"
    exit -1
fi

KUBE_CLUSTER_NAME=${KUBE_CLUSTER_NAME:-exampleapp-kube-cluster}
REGION=${REGION:-us-central1}
ZONE=$REGION-a
NODE_COUNT=${NODE_COUNT:-1}

UUID=$(od -x /dev/urandom | head -1 | awk '{OFS="-"; print $2$3$4}')
gcloud projects create example-app-${UUID} --set-as-default
gcloud alpha billing projects link $(gcloud config get-value project) --billing-account=${BILLING_ACCOUNT}

gcloud config set compute/region ${REGION}
gcloud config set compute/zone ${ZONE}
gcloud services enable container.googleapis.com
gcloud container clusters create ${KUBE_CLUSTER_NAME} --max-nodes=${NODE_COUNT}
