#!/usr/bin/env bash

minikube delete

echo
echo "Run the following commands to clear your shell environment variables:"
echo
echo "       unset DOCKER_TLS_VERIFY"
echo "       unset DOCKER_HOST"
echo "       unset DOCKER_CERT_PATH"
echo "       unset DOCKER_MACHINE_NAME"
echo