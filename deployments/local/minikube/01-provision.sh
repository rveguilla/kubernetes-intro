#!/usr/bin/env bash
MINIKUBE_DRIVER=${MINIKUBE_DRIVER:-virtualbox}
minikube start --cpus 4 --memory 4096 --vm-driver ${MINIKUBE_DRIVER}
minikube addons enable ingress

echo "To launch the Kubernetes Dashboard, run:"
echo 
echo "   minikube dashboard"
echo
echo "Run this command to configure your shell:"
echo
echo "   eval \$(minikube docker-env)"
