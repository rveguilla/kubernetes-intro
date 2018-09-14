#!/usr/bin/env bash

SERVICE_URL=http://$(minikube ip)
curl -s ${SERVICE_URL} | jq .
