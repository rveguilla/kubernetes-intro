#!/usr/bin/env bash

RESOURCE_GROUP=${RESOURCE_GROUP:-ExampleAppResourceGroup}

az group delete --name ${RESOURCE_GROUP}  --yes

for SP in ExampleAppRegistryReaderPrincipal ExampleAppRegistryContributorPrincipal; do
  SP_ID=$(az ad sp list --query="[?appDisplayName == '${SP}'].appId" -o tsv)
  if [ ! -z "${SP_ID}" ]; then
    az ad sp delete --id ${SP_ID}
  fi
done
