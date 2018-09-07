#!/usr/bin/env bash
eval $(minikube docker-env)
kubectl create configmap db-init-sql --from-file=../../../resources/initdb/init.sql
kubectl apply -f resources/example-app/
