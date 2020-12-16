
## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Linux or MacOS (preferred as some instructions are targeted for this platforms)
- On Windows: [Git Bash 4 Windows](https://gitforwindows.org/), [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

## Setup Kubernetes cluster with K3s
Duration: 10:00

We are going to setup a Kubernetes cluster with [K3s](https://k3s.io). Please note that K3s is natively available for Linux, therefore the following commands are for Linux hosts.

1. Download, install K3s (tested with versions 1.16 to 1.18) and run K3s using the following command
  ```
  curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.18.3+k3s1 K3S_KUBECONFIG_MODE="644" sh -s - --no-deploy=traefik
  ```
  This installs version `v1.18.3+k3s1` (please refer to the [K3s GitHub releases page](https://github.com/rancher/k3s/releases) for newer releases), sets file permissions `644` on `/etc/rancher/k3s/k3s.yaml` and disables `traefik` as an ingress controller.

1. Export the Kubernetes profile using
  ```
  export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
  ```

1. Verify that the connection to the cluster works:
  ```
  kubectl get nodes   
  ```


Find a full compatibility matrix for supported Kubernetes versions [here](https://keptn.sh/docs/0.7.x/operate/k8s_support/).
