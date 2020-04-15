summary: Install Keptn on EKS
id: keptn-installation-eks
categories: eks,installation
tags: keptn
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://keptn.sh


# Keptn Installation on EKS

## Welcome
Duration: 2:00

In this tutorial we are going to learn how to install Keptn in your Kubernetes cluster running in Elastic Kubernetes Services (EKS) in AWS.


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

To install the latest release of Keptn in your EKS cluster, execute the `keptn install` command with the `platform` flag specifying the target platform you would like to install Keptn on. 


```
keptn install --platform=eks
```

Positive
: The installation process will take about 5-10 minutes.


Negative
: Please read the following note if you are running EKS with an Elastic Load Balancer

If you have a custom domain or cannot use xip.io (e.g., when running Keptn on EKS with an ELB (Elastic Load Balancer) from AWS), there is the CLI command keptn configure domain to configure Keptn for your custom domain:

```
keptn configure domain YOUR_DOMAIN
```

As an example: `keptn configure domain mydemo.mydomain.com`


### Installation details 

In the Kubernetes cluster, this command creates the **keptn**, **keptn-datastore**, and **istio-system** namespace. While istio-system contains all Istio related resources, keptn and keptn-datastore contain the complete infrastructure to run Keptn. 




## Proceed with exploring Keptn
Duration: 1:00

Now that you have successfully installed Keptn, you can explore other tutorials!

Here are some possibilities:

- Take a full tour on Keptn with either [Prometheus](../../?cat=prometheus) or [Dynatrace](../../?cat=dynatrace)
- Explore [Keptn Quality Gates](../../?cat=quality-gates)
- Explore [Automated Operations with Keptn](../../?cat=automated-operations) 

