#!/usr/bin/env bash
set -e

gcloud services enable containerregistry.googleapis.com
gcloud auth configure-docker --quiet