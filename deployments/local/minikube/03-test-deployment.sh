#!/usr/bin/env bash

set -u

SERVICE_URL=http://${NAMESPACE}.minikube.local

curl -s ${SERVICE_URL}
