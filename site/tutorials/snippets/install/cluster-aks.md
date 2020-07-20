## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster in Azure. Therefore, please download the `az` command line tool. Next, please create a cluser in the [Azure Portal](https://portal.azure.com/).

1. Install local tools
  - [az](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) and make sure to be logged in to your Azure account (with `az login`)

1. Create AKS cluster
  - Master version >= `1.16.x` (tested version: `1.16.10`)
  - Size of the cluster: One **D8s_v3** node

Find a full compatibility matrix for supported Kubernetes versions [here](https://keptn.sh/docs/0.7.x/installation/k8s-support/).
