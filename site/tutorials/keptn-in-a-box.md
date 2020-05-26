summary: Keptn-in-a-Box with Dynatrace Software Intelligence empowered
id: keptn-in-a-box
categories: installation,dynatrace,microkubernetes, microk8s,full-tour,quality-gates,performance-as-a-service,automated-operations
tags: keptn06x
status: Published 
authors: Sergio Hinojosa
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials

# 🎁 Keptn in a Box 

## Welcome  
Duration: 2:00 

In this turorial you'll learn how to run and customize [Keptn-in-a-Box](https://github.com/keptn-sandbox/keptn-in-a-box). Keptn-In-A-Box is a Bash script that will convert a plain Ubuntu machine in a Single Node Kubernetes Cluster with Keptn installed and configured (among other cool features which will set sail for your autonomous cloud journey). The script is programmed in a modular way so you can select the 🧩 **installationBundle** that better suits your needs.

*Keptn-in-a-Box is a 🚀 rocket launcher for enabling tutorials or workshops in an easy, fast and ressource efficient way.*

In a matter of minutes you'll have a fully configured **Single Node Kubernetes Cluster** for learning [Keptn tutorials](https://tutorials.keptn.sh), trying out new functionalities, building your own pipeline or even delivering **Performance-as-a-Self-Service**. 

[Keptn-in-a-Box](https://github.com/keptn-sandbox/keptn-in-a-box) runs on [microk8s](https://microk8s.io/), which is a simple production-grade upstream certified Kubernetes made for developers and DevOps.

The mantra behind Keptn-In-A-Box is that you

Positive
: Spend **more** time **innovating** 😄⚗️ and *less* time *configuring* 😣🛠


![keptn-in-a-box](./assets/keptninabox/keptn-in-a-box.png)
<!--TODO Cambiar esta foto fea-->

*You can actually just run the program without any customization, but let's take the time to understand what Keptn-in-a-Box does for you and how you can customize the installation.*

### What you'll learn
- What are the requirements needed
- How to customize Keptn-in-a-Box
- How to run Keptn-in-a-Box
- How to access the configured services
- How to troubleshoot in case of troubles

Positive
: ⏰ This tutorial is dynamic, meaning the time calculated depends on the customization you provide. The most common customizations are reflected in its own steps. As you go along on this tutorial you'll find `required` ●, `recommended`⦿ and `optional`○ steps which you'll be able to skip if not desired. 

|            |            |
|------------|------------|
| Required   |     ●      |
| Recommended|     ⦿      |
| Optional   |     ○      |

## ● Get your Ubuntu box
Duration: 3:00

<!--TODO Get Ubuntu image ![Ubuntu](https://assets.ubuntu.com/v1/1be42010-cof_orange_hex.jpg) -->

### Prerequisite
The only prerequisite for Keptn-in-a-Box is that you get an Ubuntu machine and that it has an internet connection. This can be a VirtualMachine running in your datacenter, on your laptop or in a cloud provider such as Microsoft Azure, Amazon Web Services, Google Cloud among others. 
The tested distributions are  **Ubuntu Server 18.04 LTS & 20.04 LTS**

#### ☁️Get a cloud VM
Don't have a VM or a Cloud Account? Don't worry, here you can sign for a free tier in:
  - [Amazon Web Services](https://aws.amazon.com/free/) 
  - [Microsoft Azure](https://azure.microsoft.com/en-us/free/)
  - [Google Cloud](https://cloud.google.com/free)

#### 💻Get a local VM
Want to try it locally? Not a problem. Check out [multipass](https://multipass.run/)! a great way for spinning instant Ubuntu VMs in Windows, Mac or Linux computers.

### 📏Sizing
For most usecases we recommend `4 Cores`, `16 Gigs of RAM` and `20 Gigs of diskspace`. Our tests have shown that the minimum required for running Keptn-in-a-Box with all `installationBundles` is a t2.medium (2 vCPU and 4 Gib of RAM) and 10 Gigabytes of disk space. Nevertheless this won't leave much space for spinning other services or onboarding applications. 

For the ultimate experience you could get a `t2.2xlarge` with 8 Cores, 32 Gigs of RAM and 20 Gigs of diskspace.

### AWS sizings for reference 

Below is a table for the sizing reference.

|    |           |           |                  |
|----|-----------|-----------|------------------|
| -  |**Size**   |**vCPUs**  | **Memory (GiB)** |
| 😓 | t2.medium | 2         | 4                |
| 🙂 | t2.large  | 2         | 8                |
| 😊 | t2.xlarge | 4         | 16               |
| 🤓 | t2.2xlarge| 8         | 32               |

### ☎️ Open ports
If you define security rules in the Cloud provider or on your datacenter, your instance only needs to have the following pports accessible: 
- 22  / SSH 
- 80  / HTTP
- 443 / HTTPS

### Other considerations
Positive
: The functions for Keptn-in-a-Box were developed under Ubuntu but this does not mean it won't work for other Operative systems such as CentOS, Fedora, openSuse, etc... If you are willing to try it out, we would love to hear the results. Just bear in mind that the installation of Microk8s depends on [Snapcraft package manager](https://snapcraft.io/).

## ● Login to your Ubuntu box

### 💻 Login to your Ubuntu
When your Ubuntu machine is up and running, let's log in into it.
```bash
ssh yourusername@the-bind-ip-or-dns
```

### Download `keptn-in-a-box.sh`
Now let's download the `keptn-in-a-box.sh` file and make it executable.
```bash
curl -O https://raw.githubusercontent.com/keptn-sandbox/keptn-in-a-box/master/keptn-in-a-box.sh
chmod +x keptn-in-a-box.sh
```

Positive
: Any 🎨customization will take place in the `keptn-in-a-box.sh` file you just downloaded.

## ⦿ Configure Dynatrace
Duration: 1:00
For the best experience we recommend that you enable Dynatrace monitoring. 

By **only** providing your Dynatrace credentials, Keptn-in-a-Box will:
- Install the OneAgent via the [OneAgent Operator](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/monitoring/monitor-workloads-kubernetes/) for the Cluster and configure the Dynatrace Integration for Keptn.
- Configure the Dynatrace Service in Keptn.
- Download and configure the [Dynatrace ActiveGate](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/oneagent-with-helm/) for monitoring the [Kubernetes Cluster Utilization](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/monitoring/monitor-kubernetes-openshift-clusters/), [Kubernetes Events](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/monitoring/events/) and [Workloads](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/monitoring/monitor-workloads-kubernetes/).

Positive
: You have to bring your own Dynatrace tenant

If you don't have a Dynatrace tenant yet, sign up for a [free trial](https://www.dynatrace.com/trial/) or a [developer account](https://www.dynatrace.com/developer/).

Negative
: If you don't want to empower your Box with Dynatrace, skip to <a href="./#5" target="_self">Configure your Domain</a>

## ⦿ Get and enter Dynatrace credentials
Duration: 6:00

### Create a Dynatrace API Token
Log in to your Dynatrace tenant and go to **Settings > Integration > Dynatrace API**. Then, create anew API token with the following permissions
- Access problem and event feed, metrics and topology
- Access logs
- Configure maintenance windows
- Read configuration
- Write configuration
- Capture request data
- Real user monitoring JavaScript tag managemen
    
Take a look at this screenshot to double check the right token permissions for you.
![Dynatrace API Token](./assets/dt_api_token.png)

### Create a Dynatrace PaaS Token
In your Dynatrace tenant, go to **Settings > Integration > Platform as a Service**, and create a new PaaS Token.

### Enter your Dynatrace Credentials
Now that you have an API-Token and a PaaS-Token, we can enter the credentials.
In the `keptn-in-a-box.sh` file enter your credentials under the section "Define Dynatrace Environment". 
```bash
# ---- Define Dynatrace Environment ---- 
# Sample: https://{your-domain}/e/{your-environment-id} for managed or https://{your-environment-id}.live.dynatrace.com for SaaS
TENANT="https://mytenant.live.dynatrace.com"
PAASTOKEN="myDynatracePaaSToken"
APITOKEN="myDynatraceApiToken"
```

That's it! When you run the program, it will detect that you enter your credentials and will download and configure Dynatrace for you.

Negative
: Be sure that the Box is reachable by your Dynatrace environment and vice versa.

## ○ Configure your Domain 
Duration: 4:00

### Default configuration (public IP)
By default Keptn-in-a-Box will `curl ifconfig.me`  to get the public ip where it's running and will convert the IP into a magic 🧙‍♂️ domain with [nip.io](nip.io). For example if your Box is public accessible over the IP `116.203.255.68` it will convert it to `116-203-255-68.nip.io`. NIP.IO is Dead simple wildcard DNS resolution for any IP Address. 

Positive
: Having a magic domain allows you to access as much services as you want with the help of 🎡Kubernetes and Istio ⛵️. The kubernetes services will be defined as subdomains (or virtual Hosts) and resolved inside your K8s via either Istio Virtual Services or Ingresses. 

✅ If your box has a public ip, you can go with the **defaults** and leave the `DOMAIN` variable **empty**.

### Configuration for an internal IP 

Negative
: If your box does **not** have a public ip, you'll have to configure the domain so you can access the services from outside the box.  

For example, I want to run Keptn-in-a-Box inside my home network and the VM get's the IP `192.168.0.10`. I will convert the IP to a magic domain. This way the requests to any subdomain, for example to [https://api.keptn.192.168.0.10.nip.io](https://api.keptn.192.168.0.10.nip.io) will get resolved to `192.168.0.10` and then kubernetes will take care of forwarding the request internally to the Keptn API service.

Just enter the IP in a magic domain notation as shown below. The ip can contain dashes (-) or dots (.). I just like dashes more, they are prettier 💄.

```bash
# ---- Define your Domain ----   
DOMAIN="192-168-0-10.nip.io"
```

## ○ Create a workshop user account
Duration: 1:00

👨‍💻 If you want to give access to a person, this sections shows you how to enable it.
Variables,
Copy of the Repo
SSH Service
ETC

## ● Select the installation Bundle
Duration: 1:00

Table with the Bundles
Explain delegation of principles
Copy of repos
Explain how to override single flags, check the installer file

## ● Execute the script
Duration: 7:00

the User to run the commands

## Access your services
Duration: 5:00

Print the services

