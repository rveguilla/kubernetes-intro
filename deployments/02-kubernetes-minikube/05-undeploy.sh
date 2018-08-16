#!/usr/bin/env bash
eval $(minikube docker-env)
kubectl delete -f resources/example-app/
kubectl delete configmap db-init-sql
#kubectl delete persistentvolumeclaim example-app-db-persistent-volume-claim
