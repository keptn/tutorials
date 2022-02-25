
## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Linux or MacOS (preferred as some instructions are targeted for this platforms)
- On Windows: [Git Bash 4 Windows](https://gitforwindows.org/), [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster.

Negative
: Please note that at the moment only specific Minikube versions are supported.

1. Download and install [Minikube](https://github.com/kubernetes/minikube/releases) (tested with versions 1.3 to 1.10).


1. Create a new Minikube profile (named keptn) with at least 6 CPU cores and 12 GB memory using:
  ```
  minikube start -p keptn --cpus 6 --memory 12200
  ```

1. Start the Minikube LoadBalancer service in a second terminal by executing:

  ```
  minikube tunnel 
  ``` 
  
Find a full compatibility matrix for supported Kubernetes versions [here](https://keptn.sh/docs/0.12.x/operate/k8s_support/).
