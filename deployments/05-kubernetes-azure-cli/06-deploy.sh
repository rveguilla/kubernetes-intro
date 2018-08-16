#!/usr/bin/env bash
kubectl create configmap db-init-sql --from-file=../../resources/initdb/init.sql
kubectl apply -f ./output/example-app/