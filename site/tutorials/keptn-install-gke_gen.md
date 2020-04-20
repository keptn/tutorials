summary: Install Keptn on GKE
id: keptn-installation-gke
categories: gke,installation
tags: Keptn
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://keptn.sh


# Keptn Installation on GKE

## Welcome
Duration: 2:00

In this tutorial we are going to learn how to install Keptn in your Kubernetes cluster running in Google Kubernetes Engine in the Google Cloud.

Positive
: Run your Keptn installation for free on GKE! If you [sign up for a Google Cloud account](https://console.cloud.google.com/getting-started), Google gives you an initial $300 credit. For deploying Keptn you can apply for an additional $200 credit which you can use towards that GKE cluster needed to run Keptn. [Apply for your credit here](http://bit.ly/keptnongke)!


## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster in the Google Cloud Platform.

1. Install local tools
  - [gcloud](https://cloud.google.com/sdk/gcloud/)
  - [python 2.7](https://www.python.org/downloads/release/python-2716/) (required for Ubuntu 19.04)

2. Create GKE cluster
  - Master version >= `1.14.x` (tested version: `1.14.10-gke.24`)
  - One **n1-standard-8** node
  - Image type `ubuntu` or `cos` (**Note:** If you plan to use Dynatrace monitoring, select `ubuntu` for a more [convenient setup](../../reference/monitoring/dynatrace/).)
  - Sample script to create such cluster:

    ```console
    // set environment variables
    PROJECT=nameofgcloudproject
    CLUSTER_NAME=nameofcluster
    ZONE=us-central1-a
    REGION=us-central1
    GKE_VERSION="1.14"
    ```

```console
gcloud container clusters create $CLUSTER_NAME --project $PROJECT --zone $ZONE --no-enable-basic-auth --cluster-version $GKE_VERSION --machine-type "n1-standard-8" --image-type "UBUNTU" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "1" --enable-stackdriver-kubernetes --no-enable-ip-alias --network "projects/$PROJECT/global/networks/default" --subnetwork "projects/$PROJECT/regions/$REGION/subnetworks/default" --addons HorizontalPodAutoscaling,HttpLoadBalancing --no-enable-autoupgrade
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

To install the latest release of Keptn in your GKE cluster, execute the `keptn install` command with the `platform` flag specifying the target platform you would like to install Keptn on. 


```
keptn install --platform=gke
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

