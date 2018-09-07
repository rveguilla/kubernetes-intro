#!/usr/bin/env bash

SERVICE_URL=$(kubectl get ing --output='jsonpath={.items[].status.loadBalancer.ingress[].hostname}')
curl -s ${SERVICE_URL} | jq
