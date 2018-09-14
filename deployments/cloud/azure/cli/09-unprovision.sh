#!/usr/bin/env bash

SP_ID=$(az ad sp list --query="[?appDisplayName == 'ExampleAppRegistryReaderPrincipal'].appId" -o tsv)
if [ ! -z "${SP_ID}" ]; then
  az ad sp delete --id ${SP_ID}
fi

RESOURCE_GROUP=${RESOURCE_GROUP:-ExampleAppResourceGroup}

az group delete --name ${RESOURCE_GROUP}  --yes