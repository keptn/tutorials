summary: Install Keptn on Minikube
id: keptn-installation-minikube
categories: minikube,installation
tags: keptn
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://keptn.sh


# Keptn Installation on Minikube

## Welcome
Duration: 2:00

In this tutorial we are going to learn how to install Keptn in your Minikube cluster.


## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)


## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster.

Negative
: Please note that at the moment only specific Minikube versions are supported.


1. Install Minikube in [version 1.2](https://github.com/kubernetes/minikube/releases/tag/v1.2.0) (newer versions to not work at the moment).

1. Setup a Minikube VM with at least 6 CPU cores and 12 GB memory using:

  ```
  minikube stop # optional
  minikube delete # optional
  minikube start --cpus 6 --memory 12200
  ``` 

1. Start the Minikube LoadBalancer service in a second terminal by executing:

  ```
  minikube tunnel 
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

To install the latest release of Keptn in your Minikube cluster, execute the `keptn install` command with the `platform` flag specifying the target platform you would like to install Keptn on. 


```
keptn install --platform=kubernetes
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

