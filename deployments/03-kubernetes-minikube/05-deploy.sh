#!/usr/bin/env bash

envsubst < resources/example-app.yml | kubectl apply -f -
