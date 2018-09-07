#!/usr/bin/env bash

RESOURCE_GROUP=${RESOURCE_GROUP:-ExampleAppResourceGroup}
KUBE_CLUSTER_NAME=${KUBE_CLUSTER_NAME:-ExampleAppKubeCluster}
LOCATION=${LOCATION:-eastus}
NODE_COUNT=${NODE_COUNT:-3}

az group create --name ${RESOURCE_GROUP} --location ${LOCATION}
az configure --defaults group=${RESOURCE_GROUP}
az aks create --name ${KUBE_CLUSTER_NAME} --node-count ${NODE_COUNT} --generate-ssh-keys --enable-addons http_application_routing
az aks get-credentials --name ${KUBE_CLUSTER_NAME}
