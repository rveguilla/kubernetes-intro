#!/usr/bin/env bash

kubectl delete -f resources/example-app/
kubectl delete configmap db-init-sql
