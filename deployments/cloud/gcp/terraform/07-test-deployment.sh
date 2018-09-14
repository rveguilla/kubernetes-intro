#!/usr/bin/env bash
SERVICE_URL=http://$(kubectl -n example-app get ing example-app-ingress --output='jsonpath={.status.loadBalancer.ingress[].ip}')
curl -s ${SERVICE_URL} | jq .
