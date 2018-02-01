#!/usr/bin/env bash

envsubst < resources/example-app.yml | kubectl delete -f -
