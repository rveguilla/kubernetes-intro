#!/usr/bin/env bash
set -e

RESOURCE_GROUP=${RESOURCE_GROUP:-ExampleAppResourceGroup}
KUBE_CLUSTER_NAME=${KUBE_CLUSTER_NAME:-ExampleAppKubeCluster}
ACR_NAME=${ACR_NAME:-ExampleAppRegistry1}

az acr create --name ${ACR_NAME} --sku Basic
az configure --defaults acr=${ACR_NAME}

ACR_REGISTRY_ID=$(az acr show --query id --output tsv)

# Get the id of the service principal configured for AKS
CLIENT_ID=$(az aks show --name ${KUBE_CLUSTER_NAME} --query "servicePrincipalProfile.clientId" --output tsv)

# Reset default to work around bug in assignment
az configure --defaults group=''

# Create role assignment
az role assignment create --assignee ${CLIENT_ID} --role Reader --scope ${ACR_REGISTRY_ID}

az configure --defaults group=${RESOURCE_GROUP}

az acr login