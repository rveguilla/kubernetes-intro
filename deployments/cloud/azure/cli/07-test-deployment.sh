#!/usr/bin/env bash

KUBE_CLUSTER_NAME=${KUBE_CLUSTER_NAME:-ExampleAppKubeCluster}
DNS_ZONE=$(az aks show --name ExampleAppKubeCluster --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName --output tsv)
DNS_NAME="example-app.${DNS_ZONE}"
SERVICE_URL=http://${DNS_NAME}

curl -s ${SERVICE_URL} | jq .
