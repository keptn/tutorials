summary: Install Keptn on PKS
id: keptn-installation-pks
categories: pks,installation
tags: install
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://keptn.sh


# Keptn Installation on PKS

## Welcome
Duration: 2:00

In this tutorial we are going to learn how to install Keptn in your Kubernetes cluster running in Pivotal Container Service (PKS).


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

    ```console
    // set environment variables
    CLUSTER_NAME=name_of_cluster
    HOST_NAME=host_name
    PLAN=small
    ```

    ```console
    pks create-cluster $CLUSTER_NAME --external-hostname $HOST_NAME --plan $PLAN
    ```





## Download Keptn CLI
Duration: 3:00

Every release of Keptn provides binaries for the Keptn CLI. These binaries are available for Linux, macOS, and Windows.

There are multiple options how to get the Keptn CLI on your machine.

- Easiest option, if you are running on a Linux or Mac OS: 
  ```
  curl -sL https://get.keptn.sh | sudo -E bash
  ```
  This will download and install the Keptn CLI automatically.

-  Another option is to manually download the current release of the Keptn CLI:
  1. Download the version for your operating system from [Download CLI](https://github.com/keptn/keptn/releases/tag/0.6.1)
  1. Unpack the download
  1. Find the `keptn` binary in the unpacked directory

    - *Linux / macOS*: Add executable permissions (``chmod +x keptn``), and move it to the desired destination (e.g. `mv keptn /usr/local/bin/keptn`)

    - *Windows*: Copy the executable to the desired folder and add the executable to your PATH environment variable.


Now, you should be able to run the Keptn CLI: 
- Linux / macOS
  ```
  keptn --help
  ```

- Windows
  ```
  .\keptn.exe --help
  ```

Positive
: For the rest of the documentation we will stick to the *Linux / macOS* version of the commands.




## Install Keptn in your cluster
Duration: 7:00

To install the latest release of Keptn in your PKS cluster, execute the `keptn install` command with the `platform` flag specifying the target platform you would like to install Keptn on. 


```
keptn install --platform=pks
```

Positive
: The installation process will take about 5-10 minutes.

### Installation details 

In the Kubernetes cluster, this command creates the **keptn**, **keptn-datastore**, and **istio-system** namespace. While istio-system contains all Istio related resources, keptn and keptn-datastore contain the complete infrastructure to run Keptn. 




## Proceed with exploring Keptn
Duration: 1:00

Now that you have successfully installed Keptn, you can explore other tutorials!

Here are some possibilities:

- Take a full tour on Keptn with either [Prometheus](../../?cat=prometheus) or [Dynatrace](../../?cat=dynatrace)
- Explore [Keptn Quality Gates](../../?cat=quality-gates)
- Explore [Automated Operations with Keptn](../../?cat=automated-operations) 

