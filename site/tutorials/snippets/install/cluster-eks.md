
## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster in EKS.

1. Install local tools
  - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) (version >= 1.16.156)

1. Create EKS cluster on AWS. You can do so either via the online portal of AWS or via `eksctl`.
  - version >= `1.13`, version >= `1.14` recommended (tested version: `1.14`)
  - One `m5.2xlarge` node
  - Sample script using [eksctl](https://eksctl.io/introduction/installation/) to create such a cluster

    ```
    eksctl create cluster --version=1.14 --name=keptn-cluster --node-type=m5.2xlarge --nodes=1 --region=eu-west-3
    ```

Negative
: Please follow the next step if you are running EKS version 1.13

Please note that for EKS version `1.13` in our testing we learned that the default CoreDNS that comes with certain EKS versions has a bug. In order to solve that issue we can use eksctl to update the CoreDNS service like this: 

  ```
  eksctl utils update-coredns --name=keptn-cluster --region=eu-west-3 --approve
  ```
