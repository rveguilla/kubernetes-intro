#!/usr/bin/env bash

SERVICE_URL=$(minikube service --url example-app-lb)
curl -s ${SERVICE_URL} | jq
