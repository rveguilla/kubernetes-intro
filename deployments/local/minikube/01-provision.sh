#!/usr/bin/env bash
MINIKUBE_DRIVER=${MINIKUBE_DRIVER:-virtualbox}
minikube start --cpus 4 --memory 4096 --vm-driver ${MINIKUBE_DRIVER}

echo "Adding minikube.host to /etc/hosts ..."
echo "$(minikube ip) example-app-nodejs.minikube.local example-app-java.minikube.local" | sudo tee -a /etc/hosts

minikube addons enable ingress

echo "To launch the Kubernetes Dashboard, run:"
echo 
echo "   minikube dashboard"
echo

kubectl config use-context minikube