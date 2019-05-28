#!/usr/bin/env bash

set -u

for IMPL_FLAVOR in java nodejs ; do
    pushd ./${IMPL_FLAVOR}/example-app
        docker build --tag ${IMAGE_REPO}/example-app-${IMPL_FLAVOR} .
    popd
done


