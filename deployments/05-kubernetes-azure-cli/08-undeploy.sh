#!/usr/bin/env bash
kubectl delete -f ./output/example-app/
kubectl delete configmap db-init-sql
kubectl delete pv --all