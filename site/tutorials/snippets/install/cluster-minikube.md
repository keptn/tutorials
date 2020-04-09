
## Prerequisites
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)


## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster.

Negative
: Please note that at the moment only specific Minikube versions are supported.


1. Install Minikube in [version 1.2](https://github.com/kubernetes/minikube/releases/tag/v1.2.0) (newer versions to not work at the moment).

1. Setup a Minikube VM with at least 6 CPU cores and 12 GB memory using:

  ```
  minikube stop # optional
  minikube delete # optional
  minikube start --cpus 6 --memory 12200
  ``` 

1. Start the Minikube LoadBalancer service in a second terminal by executing:

  ```
  minikube tunnel 
  ``` 

