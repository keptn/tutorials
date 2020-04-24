summary: Install Keptn on AKS
id: keptn-installation-aks
categories: aks,installation
tags: keptn06x
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials


# Keptn Installation on AKS

## Welcome
Duration: 2:00

In this tutorial we are going to learn how to install Keptn in your Kubernetes cluster running in Azure Kubernetes Services (AKS) in the Azure Cloud.

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

To install the latest release of Keptn in your AKS cluster, execute the `keptn install` command with the `platform` flag specifying the target platform you would like to install Keptn on. 


```
keptn install --platform=aks
```

Positive
: The installation process will take about 5-10 minutes.

### Installation details 

In the Kubernetes cluster, this command creates the **keptn**, **keptn-datastore**, and **istio-system** namespace. While istio-system contains all Istio related resources, keptn and keptn-datastore contain the complete infrastructure to run Keptn. 




## Open Keptn's bridge
Duration: 1:00

Now that you have installed Keptn you can take a look at its user interace aka the Keptn's Bridge.

Expose the bridge via the following command to be able to access on localhost:

```
kubectl port-forward svc/bridge -n keptn 9000:8080
```

Open a browser and navigate to http://localhost:9000 to take look. The bridge will be empty at this point but when using Keptn it will be populated with events.

![empty bridge](./assets/empty-bridge.png)

Positive
: We are frequently providing early access versions of the Keptn's Bridge with new functionality - [learn more here](https://keptn.sh/docs/0.6.0/reference/keptnsbridge/#early-access-version-of-keptn-s-bridge)!


## Proceed with exploring Keptn
Duration: 1:00

Now that you have successfully installed Keptn, you can explore other tutorials!

Here are some possibilities:

- Take a full tour on Keptn with either [Prometheus](../../?cat=prometheus) or [Dynatrace](../../?cat=dynatrace)
- Explore [Keptn Quality Gates](../../?cat=quality-gates)
- Explore [Automated Operations with Keptn](../../?cat=automated-operations) 

