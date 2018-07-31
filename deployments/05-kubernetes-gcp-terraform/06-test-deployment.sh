#!/usr/bin/env bash
# We will need to somehow get the URL that is exposed by the GCP external load balancer (figure out what other steps besides in deployment file)
#                                                                                       (note: deployment file will have to be different for GCP)
SERVICE_URL=$(kubectl get service example-app-lb -o json | jq -r '.status.loadBalancer.ingress[0].ip')
curl -s ${SERVICE_URL} | jq
