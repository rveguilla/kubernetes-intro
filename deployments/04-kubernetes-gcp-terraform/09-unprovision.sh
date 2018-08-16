#!/usr/bin/env bash

if [ -z "${GCLOUD_PROJECT}" ]; then
    echo "Error: GCLOUD_PROJECT environment variable required."
    exit -1
fi

export TF_CREDS=./output/terraform-admin.json
export GOOGLE_APPLICATION_CREDENTIALS=${TF_CREDS}

terraform destroy -force resources

CONTAINER_REGISTRY=gcr.io/$(gcloud config get-value project)
for IMAGE in $(gcloud container images list --repository ${CONTAINER_REGISTRY} --format="value(name)"); do
  gcloud container images delete ${IMAGE} --force-delete-tags --quiet
done

for DISK in $(gcloud compute disks list --format="value(name)"); do
    gcloud compute disks delete ${DISK} --quiet
done

export TF_VAR_gcs_state_bucket=${GCLOUD_PROJECT}-terraform-state

gsutil rm -r gs://${TF_VAR_gcs_state_bucket}

TF_SA_EMAIL=$(gcloud iam service-accounts list --filter="displayName = 'Terraform admin account'" --format="value(email)")

gcloud projects remove-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/viewer
gcloud projects remove-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/storage.admin
gcloud projects remove-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/container.admin
gcloud projects remove-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/iam.serviceAccountUser
gcloud projects remove-iam-policy-binding ${GCLOUD_PROJECT} --member serviceAccount:${TF_SA_EMAIL} --role roles/resourcemanager.projectIamAdmin

if [ ! -z "${TF_SA_EMAIL}" ]; then
    gcloud iam service-accounts delete ${TF_SA_EMAIL} --quiet
fi


