
## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)


## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster.

Pivotal Container Service (PKS)

1. Install local tools
  - [pks CLI - v1.0.4](https://docs.pivotal.io/runtimes/pks/1-4/installing-pks-cli.html)

1. Create PKS cluster on GCP
  - Use the provided instructions for [Enterprise Pivotal Container Service (Enterprise PKS) installation on GCP](https://docs.pivotal.io/runtimes/pks/1-4/gcp-index.html)

  - Create a PKS cluster by using the PKS CLI and executing the following command:

    ```
    // set environment variables
    CLUSTER_NAME=name_of_cluster
    HOST_NAME=host_name
    PLAN=small
    ```

    ```
    pks create-cluster $CLUSTER_NAME --external-hostname $HOST_NAME --plan $PLAN
    ```

Find a full compatibility matrix for supported Kubernetes versions [here](https://keptn.sh/docs/0.7.x/installation/k8s-support/).
