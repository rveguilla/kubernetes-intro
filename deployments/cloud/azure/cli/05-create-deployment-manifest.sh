#!/usr/bin/env bash
export CONTAINER_REGISTRY=$(az acr show --query loginServer --output tsv)
export DNS_ZONE=$(az aks show --name ExampleAppKubeCluster --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName --output tsv)
export DNS_NAME=example-app.${DNS_ZONE}

mkdir -p ./output/example-app/

for K8_MANIFEST in $(ls -1 resources/example-app/*.yml); do
    cat ${K8_MANIFEST} | envsubst > ./output/example-app/$(basename ${K8_MANIFEST})
done

