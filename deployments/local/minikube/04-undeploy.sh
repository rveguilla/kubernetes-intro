#!/usr/bin/env bash

set -u

kubectl -n ${NAMESPACE} delete -Rf ./output/