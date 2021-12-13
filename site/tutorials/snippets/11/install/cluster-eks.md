
## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Linux or MacOS (preferred as some instructions are targeted for this platforms)
- On Windows: [Git Bash 4 Windows](https://gitforwindows.org/), [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster in EKS.

1. Install local tools
  - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) (version >= 1.16.156)

1. Create EKS cluster on AWS. You can do so either via the online portal of AWS or via `eksctl`.
  - version 1.17 (tested version: 1.17)
  - One `m5.2xlarge` node. Please note that you might go for a smaller or larger size cluster depending on the concrete use case. The suggested sizing is based on the recommendation for the [full tour](../../?cat=full-tour) tutorials.
  - Sample script using [eksctl](https://eksctl.io/introduction/#installation) to create such a cluster

    ```
    eksctl create cluster --version=1.17 --name=keptn-cluster --node-type=m5.2xlarge --nodes=1 --region=eu-west-3
    ```

Find a full compatibility matrix for supported Kubernetes versions [here](https://keptn.sh/docs/0.10.x/operate/k8s_support/).
