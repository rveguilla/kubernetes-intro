#!/usr/bin/env bash

SWARM_PREFIX=${SWARM_PREFIX:-swarm}
DOCKER_MACHINE_DRIVER=${DOCKER_MACHINE_DRIVER:-virtualbox}
MAX_NODES=${MAX_NODES:-2}

PRIMARY_MANAGER_NODE="${SWARM_PREFIX}-manager-1"
echo =====================================
echo "Creating ${PRIMARY_MANAGER_NODE}..."
echo =====================================
docker-machine create \
 --driver ${DOCKER_MACHINE_DRIVER} \
 ${PRIMARY_MANAGER_NODE}
MANAGER_IP=$(docker-machine ip ${PRIMARY_MANAGER_NODE})

docker-machine ssh ${PRIMARY_MANAGER_NODE} "docker swarm init --advertise-addr ${MANAGER_IP}"

MANAGER_JOIN_TOKEN=$(docker-machine ssh ${PRIMARY_MANAGER_NODE} docker swarm join-token --quiet manager)
WORKER_JOIN_TOKEN=$(docker-machine ssh ${PRIMARY_MANAGER_NODE} docker swarm join-token --quiet worker)

for (( NODE_NUM=1; NODE_NUM<=${MAX_NODES}; NODE_NUM++ )); do
   WORKER_NODE="${SWARM_PREFIX}-worker-${NODE_NUM}"
   echo =====================================
   echo "Creating ${WORKER_NODE}..."
   echo =====================================
   docker-machine create \
        --driver ${DOCKER_MACHINE_DRIVER} \
        ${WORKER_NODE}
   docker-machine ssh ${WORKER_NODE} "docker swarm join --token ${WORKER_JOIN_TOKEN} ${MANAGER_IP}:2377"
done
eval $(docker-machine env ${PRIMARY_MANAGER_NODE})
echo =====================================
echo "Deploying portainer stack..."
echo =====================================

docker stack deploy --compose-file ./resources/portainer.yml portainer

OPEN=$(which open)
if [ -x ${OPEN} ]; then
    open http://${MANAGER_IP}:9000/#/dashboard
fi

echo =====================================
echo "Cluster ${SWARM_PREFIX} ready!"
echo =====================================
echo
echo "portainer URL: http://${MANAGER_IP}:9000"
echo
echo "Run this command to configure your shell:"
echo
echo "   eval \$(docker-machine env ${PRIMARY_MANAGER_NODE})"
