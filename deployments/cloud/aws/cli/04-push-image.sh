#!/usr/bin/env bash
REGISTRY_ID=$(aws ecr describe-repositories --repository-names example-app --query "repositories[0].registryId" --output text)
CONTAINER_REGISTRY=${REGISTRY_ID}.dkr.ecr.us-east-1.amazonaws.com
docker push ${CONTAINER_REGISTRY}/example-app
