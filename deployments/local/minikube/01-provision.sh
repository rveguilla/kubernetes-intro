#!/usr/bin/env bash
MINIKUBE_DRIVER=${MINIKUBE_DRIVER:-virtualbox}
MINIKUBE_CONTAINER_RUNTIME=${MINIKUBE_CONTAINER_RUNTIME:-cri-o}
minikube start \
   --vm-driver ${MINIKUBE_DRIVER} \
   --container-runtime=${MINIKUBE_CONTAINER_RUNTIME} \
   --cpus 4 --memory 4096 

echo "Adding minikube.host to /etc/hosts ..."
echo "$(minikube ip) example-app-nodejs.minikube.local example-app-java.minikube.local" | sudo tee -a /etc/hosts

minikube addons enable ingress

echo "To launch the Kubernetes Dashboard, run:"
echo 
echo "   minikube dashboard"
echo

kubectl config use-context minikube