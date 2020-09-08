summary: My first tutorial
id: keptn-control-plane-k3s
categories: k3s,Dynatrace,Prometheus,quality-gates,automated-operations,installation
tags: keptn06x
status: Draft 
authors: Thomas Schuetz
Feedback Link: https://keptn.sh


# Install Keptn on K3s

## Welcome
Duration: 10:00

In this tutorial we are going to learn how to install keptn on k3s.

### What you'll learn

- Find out what k3s is and why it is a good boat for keptn
- Install the keptn control plane on k3s 
- How to take the next steps ...

## Before you start

Why would you want to do this?
* keptn is deployed mainly on kubernetes
* Often, you don't want to deal with a full-featured Kubernetes cluster to simply try out keptn (quality gates)
* Therefore, you would like to install a lightweight Kubernetes cluster, install keptn and simply use it

Positive
: This installation method is only useful, when you want to install keptn on a plain Linux system (without Kubernetes). When you already have a Kubernetes installation available and want to install keptn there, just use the keptn installation tutorials. 

What is K3s?
* It is a lightweight, CNCF-certified Kubernetes distribution
* k3s is shipped as a single binary (including kubectl and all k8s components)
* Very simple installation
* Ingress and HostPath Provisioner included
* Further reading: [k3s.io](https://k3s.io)

### Disclaimer
Negative
: Although the [k3s](https://k3s.io) installation is running smoothly, [keptn-on-k3s](https://github.com/keptn-sandbox/keptn-on-k3s) is currently a sandbox project. Therefore, keep following things in mind:
 * Currently, this is only working for the control plane (quality gates)
 * It is using the experimental [manifest installation](https://keptn.sh/docs/0.6.0/reference/manifest_installation/)
 * Upgrading via the keptn CLI is not supported
 * Do not use this in production (at the moment)
 
But:

Positive
: You can help getting keptn-on-k3s a production-grade installation method by trying it out and contributing your findings and/or new features (such as additional cloud providers).


## Prerequisites
To start the keptn-on-k3s installation properly, you need a machine running Linux with the `curl` package installed.

Currently, this has been tested using following distributions:
* CentOS 8
* ArchLinux
* Debian on GCP
* Amazon Linux

### Hardware Requirements:
* 1(v)CPU and 4GB of memory

### Cloud Providers "supported" (Mechanism for detecting the external IP is available)
* Google Cloud Platform
* Amazon Web Services
* Digital Ocean

## (Optional) Gather Dynatrace tokens
Duration: 6:00

If you want to install keptn-on-k3s with Dynatrace support, you will need to create a Dynatrace token.

1. Create a Dynatrace API Token

    Log in to your Dynatrace tenant and go to **Settings > Integration > Dynatrace API**. Then, create a new API token with the following permissions:

    - Access problem and event feed, metrics and topology
    - Access logs
    - Read configuration
    - Write configuration
    - Capture request data

    Take a look at this screenshot to double check the right token permissions for you.

    ![Dynatrace API Token](./assets/dt_api_token.png)

1. Set the DT_API_TOKEN and DT_TENANT environment variables
    ```
    export DT_TENANT=yourtenant.live.dynatrace.com
    export DT_API_TOKEN=yourAPItoken
    ```

## Install keptn on k3s
Keptn-on-k3s is a keptn-sandbox project at the moment. It is a very simple shell script, which installs k3s (from their GitHub Repository) and afterwards applies the manifests for keptn.

The keptn-dynatrace-service or the keptn-prometheus-service can also be installed automatically with keptn-on-k3s.  This can be achieved by specifying a provider (this will query the corresponding metadata endpoint) or set the IP address manually. If `hostname -I` is working on the machine and no provider or IP address is specified, the installer will use the first reasonable IP address.

To expose keptn's bridge and the api via an ingress controller, keptn-on-k3s needs to know the IP address which will be used (to generate a xip.io entry and the Ingress objects).

You can install keptn-on-k3s (with autodetection of your IP address using the command `hostname -I`):
```shell script
curl -Lsf https://raw.githubusercontent.com/keptn-sandbox/keptn-on-k3s/master/install-keptn-on-k3s.sh | bash -s - 
```  

### (Optional): Specifying the source of the IP address
When installing keptn-on-k3s on a public cloud, the IP address can not be detected directly on the host. Therefore, a `--provider` option is implemented, which instructs the script to query the metadata endpoint of the the specified cloud provider and get the public ip address of the node. 

As a result, the installation- of keptn-on-k3s on a cloud provider can be triggered using the command:

```shell script
curl -Lsf https://raw.githubusercontent.com/keptn-sandbox/keptn-on-k3s/master/install-keptn-on-k3s.sh | bash -s - --provider [gke|aks|digitalocean]
```  

It may be the case, that you want to specify the IP address manually, this can be achieved using the `--ip` option:
```shell script
curl -Lsf https://raw.githubusercontent.com/keptn-sandbox/keptn-on-k3s/master/install-keptn-on-k3s.sh | bash -s - --ip [your-ip]
```  

### (Optional): Installing Add-Ons
Additionally, you can install keptn-on-k3s with support for Dynatrace, Prometheus or the jMeter service. This can be done via the `--with-dynatrace`, `--with-prometheus` or `--with-jmeter` flags.

Negative
: When installing `--with-dynatrace`, you have to specify the credentials used before executing the script. Therefore, DT_API_TOKEN (a Dynatrace API Token) and DT_TENANT (Dynatrace Tenant URL) have to be set as environment variable.

{{ snippets/06/install/download-keptnCLI.md }}

## Talking to the keptn
After installation, you get the required information needed to communicate with the keptn API or to access the keptn's Bridge. Therefore, the following output is shown at the end of the installation (In this example, `-ip 127.0.0.1` has been used for the installation):

```text
API URL   :      https://api.keptn.127.0.0.1.xip.io
Bridge URL:      https://bridge.keptn.127.0.0.1.xip.io
Bridge Username: keptn
Bridge Password: FvSv8KLD1sCa7LWrW1yEV7TUAy6g5T35
API Token :      qonZAH53/L/LbN7Rph9Mkg==
To use keptn:
- Install the keptn CLI: curl -sL https://get.keptn.sh | sudo -E bash
- Authenticate: keptn auth  --api-token "qonZAH53/L/LbN7Rph9Mkg==" --endpoint "https://api.keptn.127.0.0.1.xip.io"
```

### Connecting the keptn CLI to the API
Using this information, you can simply connect the keptn CLI to the API

`keptn auth --endpoint=API-URL --api-token=API-Token`

At the end a message indicating that you are successfully authenticated should be shown.

### Accessing the Bridge
The keptn's bridge is exposed automatically, and can be accessed using the URL and the credentials which are displayed after the installation.

## Congratulations!
Positive
: You have installed the keptn control plane on a single-node Kubernetes cluster (K3s) and configured the keptn CLI to access it.

## Proceed with exploring keptn
Now that you have successfully installed the keptn control plane, you may want to configure quality gates. 

Positive
: Depending on your use case and when installing your application on the k3s "cluster", you may need additional CPU and memory resources.

Here are some possibilities:
* Configure [keptn Quality Gates with Prometheus](../keptn-quality-gates-prometheus/index.html) 
  * Skip 2, 3, 4, 5, 8 (when installed `--with-prometheus`)
* Configure [keptn Quality Gates with Dynatrace](../keptn-quality-gates-dynatrace/index.html)
  * You might have already installed the Dynatrace integration (`--with-dynatrace`) 
