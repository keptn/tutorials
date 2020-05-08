## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster in Azure. Therefore, please download the `az` command line tool. Next, please create a cluser in the [Azure Portal](https://portal.azure.com/).

1. Install local tools
  - [az](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

1. Create AKS cluster
  - Master version >= `1.15.x` (tested version: `1.15.5`)
  - Size of the cluster: One **D8s_v3** node

