#!/usr/bin/env bash
MINIKUBE_DRIVER=${MINIKUBE_DRIVER:-virtualbox}
minikube start --cpus 4 --memory 4096 --vm-driver ${MINIKUBE_DRIVER}
minikube addons enable ingress


minikube dashboard
DASHBOARD_URL=$(minikube dashboard --url)
echo "Run this command to configure your shell:"
echo
echo "   Kubernetes Dashboard URL : ${DASHBOARD_URL}"
echo
echo "   eval \$(minikube docker-env)"
