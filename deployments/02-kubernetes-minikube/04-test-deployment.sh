#!/usr/bin/env bash

SERVICE_URL=$(minikube ip)
curl -s ${SERVICE_URL} | jq
