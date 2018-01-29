#!/usr/bin/env bash
minikube start --cpus 4 --memory 4096 --kubernetes-version v1.9.0 --bootstrapper kubeadm
minikube dashboard

DASHBOARD_URL=$(minikube dashboard --url)
echo "Run this command to configure your shell:"
echo
echo "   Kubernetes Dashboard URL : ${DASHBOARD_URL}"
echo
echo "   eval \$(minikube docker-env)"
