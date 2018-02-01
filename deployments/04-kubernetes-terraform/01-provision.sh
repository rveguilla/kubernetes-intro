#!/usr/bin/env bash
# Make sure perquisites are done
#  1. GCP Account created (gcloud auth login)
#  2. GCP SDK is downloaded and installed
# Create google cloud project
# get service account credentials
# run terraform script to access
#export TF_ADMIN=${USER}-terraform-admin
#export TF_CREDS=./resources/account.json

if [ -z "${TF_VAR_username}" ]; then
    echo "You need to set an environment variable TF_VAR_username."
    exit
fi

if [ -z "${TF_VAR_password}" ]; then
    echo "You need to set an environment variable TF_VAR_password."
    exit
fi

#if [ -z "${TF_VAR_gcp_project_id}" ]; then
#    echo "Setting project id"
#    TF_VAR_gcp_project_id="randomprojectname"
#    TF_VAR_gcp_project_id+=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-z0-9' | fold -w 6 | head -n 1)
#    export TF_VAR_gcp_project_id="${TF_VAR_gcp_project_id}"
#    export DOCKER_REGISTRY_NAMESPACE="${TF_VAR_gcp_project_id}"
#fi
#
#echo "gcloud projects create ${TF_VAR_gcp_project_id}"
#gcloud projects create ${TF_VAR_gcp_project_id}
#echo "gcloud config set project ${TF_VAR_gcp_project_id}"
#gcloud config set project ${TF_VAR_gcp_project_id}
#echo "getting credentials for service account"
#gcloud iam service-accounts create terraform \
#  --display-name "Terraform admin account"
#gcloud iam service-accounts keys create ${TF_CREDS} \
#  --iam-account terraform@${TF_VAR_gcp_project_id}.iam.gserviceaccount.com
#
#gcloud projects add-iam-policy-binding ${TF_VAR_gcp_project_id} --member serviceAccount:terraform@${TF_VAR_gcp_project_id}.iam.gserviceaccount.com --role roles/viewer
#gcloud projects add-iam-policy-binding ${TF_VAR_gcp_project_id} --member serviceAccount:terraform@${TF_VAR_gcp_project_id}.iam.gserviceaccount.com --role roles/storage.admin

echo "running terraform to setup GKE cluster"
terraform apply resources