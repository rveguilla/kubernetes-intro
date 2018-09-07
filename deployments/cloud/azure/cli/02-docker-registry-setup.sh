#!/usr/bin/env bash
set -e

RESOURCE_GROUP=${RESOURCE_GROUP:-ExampleAppResourceGroup}
ACR_NAME=${ACR_NAME:-ExampleAppRegistry1}

az acr create --name ${ACR_NAME} --sku Basic
az configure --defaults acr=${ACR_NAME}

CONTAINER_REGISTRY=$(az acr show --query loginServer --output tsv)
ACR_REGISTRY_ID=$(az acr show --query id --output tsv)

ACR_READER_SP=ExampleAppRegistryReaderPrincipal

ACR_READER_SP_RESOURCE=$(az ad sp create-for-rbac --name ${ACR_READER_SP} --role Reader --scopes ${ACR_REGISTRY_ID})
ACR_READER_USERNAME=$(echo ${ACR_READER_SP_RESOURCE} | jq -r '.appId')
ACR_READER_PASSWORD=$(echo ${ACR_READER_SP_RESOURCE} | jq -r '.password')
ACR_READER_EMAIL="ExampleAppRegistryReaderPrincipal@ExampleAppRegistry1Principal.net"
echo ${ACR_READER_SP_RESOURCE}

az acr login

kubectl create secret docker-registry acr-auth \
                --docker-username=${ACR_READER_USERNAME} \
                --docker-password=${ACR_READER_PASSWORD} \
                --docker-email="${ACR_READER_EMAIL}" \
                --docker-server=${CONTAINER_REGISTRY}
