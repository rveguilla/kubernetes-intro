#!/usr/bin/env bash

if [ -z "${GCLOUD_PROJECT}" ]; then
    echo "Error: GCLOUD_PROJECT environment variable required."
    exit -1
else
    BILLING_ACCOUNTS=$(gcloud alpha billing accounts list --filter="open = true" --format "value(name)")
    BILLING_ENABLED="False"
    for ACCOUNT in $BILLING_ACCOUNTS; do
        BILLING_ENABLED=$(gcloud alpha billing projects list --billing-account ${ACCOUNT} --filter "projectId=${GCLOUD_PROJECT}" --format="value(billingEnabled)")
        if [ "${BILLING_ENABLED}" == "True" ]; then        
            break
        fi    
    done  
  
    if [ "${BILLING_ENABLED}" == "False" ]; then
        echo "Error: GCLOUD_PROJECT is not currently linked with an active billing account."
        exit -1 
    fi  
fi


KUBE_CLUSTER_NAME=${KUBE_CLUSTER_NAME:-exampleapp-kube-cluster}
REGION=${REGION:-us-central1}
ZONE=$REGION-a
NODE_COUNT=${NODE_COUNT:-1}

gcloud config set project ${GCLOUD_PROJECT}
gcloud config set compute/region ${REGION}
gcloud config set compute/zone ${ZONE}
gcloud services enable container.googleapis.com compute.googleapis.com
gcloud container clusters create ${KUBE_CLUSTER_NAME} --max-nodes=${NODE_COUNT}
