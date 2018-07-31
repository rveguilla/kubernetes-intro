#!/bin/bash

ACR_NAME=ExampleAppRegistry1
SERVICE_PRINCIPAL_NAME=ExampleAppRegistry1Principal

# Populate the ACR login server and resource id.
CONTAINER_REGISTRY=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)
# Create a 'Reader' role assignment with a scope of the ACR resource.
SP_PASSWD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --role Reader --scopes $ACR_REGISTRY_ID --query password --output tsv)

# Get the service principal client id.
CLIENT_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)

# Output used when creating Kubernetes secret.
echo "Service principal ID: $CLIENT_ID"
echo "Service principal password: $SP_PASSWD"


kubectl create secret docker-registry acr-auth --docker-username=${CLIENT_ID} --docker-password=${SP_PASSWD} --docker-email="ExampleAppRegistry1Principal@ExampleAppRegistry1Principal.net" --docker-server=${CONTAINER_REGISTRY} 
