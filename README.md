
## Description

Example MySQL-Express-NodeJS app with deployment scripts for the following container environments:

1. Local Docker host (non-swarm mode).
1. Local Docker Swarm cluster provisioned using docker-machine/virtuabox.
1. Local Kubernetes cluster provisioned using minikube/virtuabox.
1. Google Kubernetes Engine (GKE) cluster, provisioned using Terraform.

## Requirements:

### Notes:
1. At this time, the example code has only been tested on Unix operating systems. 
1. All of the following tools are available on macOS via [homebrew](https://brew.sh).
 
### Tools: 
1. [NodeJS](https://nodejs.org) / [Yarn](https://yarnpkg.com)
1. [docker / docker-compose / docker-machine](https://www.docker.com/community-edition) 
1. [VirtuaBox](https://www.virtualbox.org)
1. [kubernetes-cli](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
1. [minikube](https://github.com/kubernetes/minikube)
1. curl
1. envsubst (if not present on macOS, install 'gettext package via homebrew).
