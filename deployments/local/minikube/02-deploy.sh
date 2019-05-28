#!/usr/bin/env bash

set -u

export IMAGE=${IMAGE}
export PORT=${PORT}

rm -rf ./output/
mkdir -p ./output/

for INPUT_MANIFEST in $(find ./manifests -iname '*.yml'); do
    OUTPUT_MANIFEST=$(echo ${INPUT_MANIFEST}  | sed -e 's/manifests/output/g')
    mkdir -p $(dirname ${OUTPUT_MANIFEST})
    cat ${INPUT_MANIFEST} | envsubst > ${OUTPUT_MANIFEST}
done


kubectl create namespace ${NAMESPACE} || true

kubectl -n ${NAMESPACE} apply -Rf ./output/
