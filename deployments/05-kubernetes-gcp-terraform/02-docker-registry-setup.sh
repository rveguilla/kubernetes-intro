#!/usr/bin/env bash
echo "On the browser:
   1. Go to your GCP console at console.cloud.google.com
   2. A new registry should be associated to the account you have created
On the terminal, run:
    docker login -u _json_key -p \“\$(cat key.json)\” https://gcr.io
and then:
   export DOCKER_REGISTRY_NAMESPACE=<google_project_id>"

