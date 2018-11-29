
## Description

Example MySQL-Express-NodeJS app with deployment scripts for the following container environments:

1. Local Docker host (non-swarm mode).
1. Local Kubernetes cluster provisioned using minikube/virtuabox.
1. Local Kubernetes cluster provisioned using Docker for Mac Kubernetes support.
1. Google Kubernetes Engine (GKE) cluster, provisioned using Google Cloud SDK (cli).
1. Google Kubernetes Engine (GKE) cluster, provisioned using Terraform.
1. Azure Kubernetes Engine (AKS) cluster, provisioned using Azure CLI.
1. Amazon Elastic Container Service for Kubernetes (EKS) cluster, provisioned using AWS CLI.


## Requirements:

### Notes:
1. At this time, the example code has only been tested on Unix operating systems. 
1. All of the following tools are available on macOS via [homebrew](https://brew.sh).
 
### Tools: 
1. [NodeJS](https://nodejs.org) / [Yarn](https://yarnpkg.com)
1. [Docker](https://www.docker.com/get-started) 
1. [VirtuaBox](https://www.virtualbox.org)
1. [kubernetes-cli](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
1. [minikube](https://github.com/kubernetes/minikube)
1. [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
1. [Google Cloud SDK](https://cloud.google.com/sdk)
1. [JQ](https://stedolan.github.io/jq/)
1. curl
1. envsubst (if not present on macOS, install 'gettext package via homebrew).
    ``` 
    brew install gettext
    brew link --force gettext
    ``` 
