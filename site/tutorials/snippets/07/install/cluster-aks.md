## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Linux or MacOS (preferred as some instructions are targeted for this platforms)
- On Windows: [Git Bash 4 Windows](https://gitforwindows.org/), [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster in Azure. Therefore, please download the `az` command line tool. Next, please create a cluster in the [Azure Portal](https://portal.azure.com/).

1. Install local tools
  - [az](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and make sure to be logged in to your Azure account (with `az login`)

1. Create AKS cluster
  - Master version >= `1.15.x` (tested version: `1.16.10`)
  - Size of the cluster: One **D8s_v3** node. Please note that you might go for a smaller or larger size cluster depending on the concrete use case. The suggested sizing is based on the recommendation for the [full tour](../../?cat=full-tour) tutorials.

Find a full compatibility matrix for supported Kubernetes versions [here](https://keptn.sh/docs/0.7.x/operate/k8s_support/).
