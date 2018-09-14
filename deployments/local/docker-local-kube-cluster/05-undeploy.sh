#!/usr/bin/env bash

kubectl delete namespace example-app
# needed with local kubernetes ?
kubectl -n example-app delete pod example-app-db-0 --grace-period=0 --force