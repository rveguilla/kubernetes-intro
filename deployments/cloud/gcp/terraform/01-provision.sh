#!/usr/bin/env bash

if [ -z "${GCLOUD_PROJECT}" ]; then
    echo "Error: GCLOUD_PROJECT environment variable required."
    exit -1
fi


mkdir -p output    

export GCLOUD_REGION=us-central1
export GCLOUD_ZONE=${GCLOUD_REGION}-a

gcloud config set project ${GCLOUD_PROJECT}
gcloud config set compute/region ${GCLOUD_REGION}
gcloud config set compute/zone ${GCLOUD_ZONE}

gcloud services enable container.googleapis.com

export TF_CREDS=./output/terraform-admin.json

TF_SA_EMAIL=$(gcloud iam service-accounts create terraform --display-name "Terraform admin account" --format="value(email)")
gcloud iam service-accounts keys create ${TF_CREDS} --iam-account ${TF_SA_EMAIL}

gcloud projects add-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/viewer
gcloud projects add-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/storage.admin
gcloud projects add-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/container.admin
gcloud projects add-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/resourcemanager.projectIamAdmin

export TF_VAR_gcs_state_bucket=${GCLOUD_PROJECT}-terraform-state

gsutil mb gs://${TF_VAR_gcs_state_bucket}

gsutil versioning set on gs://${TF_VAR_gcs_state_bucket}

export GOOGLE_APPLICATION_CREDENTIALS=${TF_CREDS}
rm -rf .terraform
terraform init -backend-config="bucket=${TF_VAR_gcs_state_bucket}" resources

export TF_VAR_node_count=3
terraform plan -out output/terraform_plan resources
terraform apply output/terraform_plan