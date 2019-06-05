
## Description

Example project showing basic Kubernetes concepts using one of two different implementation of a simple
REST app backed by MySQL with deployment scripts Minikube:


## Requirements:

### Notes:
1. At this time, the example code has only been tested on Unix operating systems. 
1. All of the following tools are available on macOS via [homebrew](https://brew.sh).
 
### Tools: 
1. [Docker](https://www.docker.com/get-started) 
1. [VirtuaBox](https://www.virtualbox.org)
1. [kubernetes-cli](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
1. [minikube](https://github.com/kubernetes/minikube)
1. [JQ](https://stedolan.github.io/jq/)
1. curl
1. envsubst (if not present on macOS, install `gettext`package via homebrew).
    ``` 
    brew install gettext
    brew link --force gettext
    ``` 
