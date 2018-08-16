#!/usr/bin/env bash
minikube start --cpus 4 --memory 4096 --bootstrapper kubeadm
minikube addons enable ingress


minikube dashboard
DASHBOARD_URL=$(minikube dashboard --url)
echo "Run this command to configure your shell:"
echo
echo "   Kubernetes Dashboard URL : ${DASHBOARD_URL}"
echo
echo "   eval \$(minikube docker-env)"
