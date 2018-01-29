#!/usr/bin/env bash

SWARM_PREFIX=${SWARM_PREFIX:-swarm}
PRIMARY_MANAGER_NODE="${SWARM_PREFIX}-manager-1"
MANAGER_IP=$(docker-machine ip ${PRIMARY_MANAGER_NODE})
SERVICE_URL=http://${MANAGER_IP}:3000
curl -s ${SERVICE_URL} | jq
