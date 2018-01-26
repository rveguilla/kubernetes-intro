#!/usr/bin/env bash

SWARM_PREFIX=${SWARM_PREFIX:-swarm}
DOCKER_MACHINE_DRIVER=${DOCKER_MACHINE_DRIVER:-virtualbox}

NODE_LIST=$(docker-machine ls --filter name=${SWARM_PREFIX} --quiet)

for NODE in ${NODE_LIST}; do

    docker-machine rm -y ${NODE} > /dev/null
    if [ "${?}" == "0" ]; then
        echo "Successfully removed ${NODE}"
    fi
done

echo
echo "Run this command to clear your shell environment variables:"
echo
echo "   eval \$(docker-machine env --unset)"
