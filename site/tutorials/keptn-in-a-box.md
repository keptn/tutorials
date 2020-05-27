summary: Keptn-in-a-Box with Dynatrace Software Intelligence empowered
id: keptn-in-a-box
categories: microk8s, dynatrace,installation, microkubernetes, microk8s,full-tour,quality-gates,performance-as-a-service,automated-operations
tags: keptn06x
status: Published 
authors: Sergio Hinojosa
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials

# Keptn in a Box

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
: ⏰ This tutorial is dynamic, meaning the time calculated depends on the customization you provide. The most common customizations are reflected in its own steps. As you go along on this tutorial you'll find `recommended`⦿ and `optional`○ steps which you'll be able to skip if not desired. 

|            |            |
|------------|------------|
| Recommended|     ⦿      |
| Optional   |     ○      |

## Get your Ubuntu box
Duration: 5:00

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
For most usecases we recommend `4 Cores`, `16 Gigs of RAM` and `20 Gigs of diskspace`. Our tests on aws have shown that the minimum required for running Keptn-in-a-Box with the default `installation bundle` is a t2.medium (2 vCPU and 4 Gib of RAM) and 10 Gigabytes of disk space. Nevertheless this won't leave much space for spinning other services or onboarding applications. 

For the 😎 ultimate experience you could get a `t2.2xlarge` with 8 Cores, 32 Gigs of RAM and 20 Gigs of diskspace.

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
If you define security rules in the Cloud provider or on your datacenter, your instance only needs to have the following ports accessible: 
- 22  / SSH 
- 80  / HTTP
- 443 / HTTPS

### Other considerations
Positive
: The functions for Keptn-in-a-Box were developed under Ubuntu but this does not mean it won't work for other Operative systems such as CentOS, Fedora, openSuse, etc... If you are willing to try it out, we would love to hear the results. Just bear in mind that the installation of Microk8s depends on [Snapcraft package manager](https://snapcraft.io/). Your chances are quite high since Microk8s is available in 42 Linux flavours.

## Login to your Ubuntu box
Duration: 1:00

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

## ⦿ Dynatrace Integration
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

## ⦿ Configure Dynatrace
Duration: 6:00

### Create a Dynatrace API Token
Log in to your Dynatrace tenant and go to **Settings > Integration > Dynatrace API**. Then, create anew API token with the following permissions
- Access problem and event feed, metrics and topology
- Access logs
- Read configuration
- Write configuration
- Capture request data
- Real user monitoring JavaScript tag management
    
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
Duration: 3:00

### Default configuration (public IP)
By default Keptn-in-a-Box will `curl ifconfig.me`  to get the public  IP where it's running and will convert the IP  into a magic 🧙‍♂️ domain with [nip.io](nip.io). For example if your Box is public accessible over the IP  `116.203.255.68` it will convert it to `116-203-255-68.nip.io`. NIP.IO is a simple wildcard DNS resolution for any IP Address. 

Positive
: Having a magic domain allows you to access as much services as you want with the help of 🎡Kubernetes and Istio ⛵️. The kubernetes services will be defined as subdomains (or virtual Hosts) and resolved inside your K8s via either Istio Virtual Services or Ingresses. 

✅ If your box has a public ip, you can go with the **defaults** and leave the `DOMAIN` variable **empty**.

### Configuration for an internal IP 

Negative
: If your box does **not** have a public ip, you'll have to configure the domain so you can access the services from outside the box.  

For example, I want to run Keptn-in-a-Box inside my home network and the VM get's the ip `192.168.0.10`. I will convert the IP to a magic domain. This way the requests to any subdomain, for example to [https://api.keptn.192.168.0.10.nip.io](https://api.keptn.192.168.0.10.nip.io) will get resolved to `192.168.0.10` and then kubernetes will take care of forwarding the request internally to the Keptn API service.

Just enter the IP in a magic domain notation as shown below. The ip can contain dashes (-) or dots (.). I just like dashes more, they are prettier 💄.

```bash
# ---- Define your Domain ----   
DOMAIN="192-168-0-10.nip.io"
```

With the above example you'll be able to access the teaser at [http://192-168-0-10.nip.io](http://192-168-0-10.nip.io)

![autonomous-cloud-teaser](./assets/keptninabox/ac-teaser.jpg)

## ○ Create a workshop user account
Duration: 2:00

👨‍💻 A common feature is to use this box for workshops providing access to a guest user. If you spin the instances with a private key and you don't want to share your SSH Key, this feature will create a user, clone the home directory of the `$USER` who runs the program with its folders (such as keptn-examples) and configurations for the `bash` and clients like `helm`, `istioctl`,`kubectl`, `docker` and `keptn`. 

The following variables will define the User Account and the SSH password. Set the variables as you desire:
```bash
# ---- Workshop User  ---- 
NEWUSER="dynatrace"
NEWPWD="dynatrace"
```
This functionality is disabled by default but can be independently enabled with any installation bundle. The function flag 

```bash
create_workshop_user=true
```
needs to be active and defined after the installation bundles section. More about **functions**, **control flags** and **installationBundles** in the step **select the Installation Bundle**.

Negative
: ⚠️ This function will enable password authentication in `/etc/ssh/sshd_config` and restart the `sshd` service. The workshop user will also be part of the suders group.

## Select the installation Bundle
Duration: 7:00

### ↳ Programs logic
Before selecting the installation Bundle, let's understand how `Keptn-in-a-box.sh` works and what it will do.

[keptn-in-a-box.sh](https://github.com/keptn-sandbox/keptn-in-a-box/blob/master/keptn-in-a-box.sh) is the controller. Here we have been defining our variables. When executing this script, it will download and load the functions defined in [functions.sh](https://github.com/keptn-sandbox/keptn-in-a-box/blob/master/functions.sh). Which **⨍ functions** to execute are controled by their **🚦control flags**. Now, an **🧩installation Bundle** is the enablement for multiple **control flags**. 

### 🧩installation Bundles
Now that we have understood the delegation of the program's logic and it's main components, here is a table of the installation Bundles and their respective enabled flags:


|                                     |           |            |              |              |
|-------------------------------------|-----------|------------|--------------|--------------|    
|**🚦control flag**                     |**🧩Demo** |**🧩Workshop**|**🧩KeptnOnly**|**🧩All**|    
| update_ubuntu                       |     ✅    |     ✅     |      ✅     |      ✅     |    
| docker_install                      |     ✅    |     ✅     |      ✅     |      ✅     |    
| microk8s_install                    |     ✅    |     ✅     |      ✅     |      ✅     |    
| setup_proaliases                    |     ✅    |     ✅     |      ✅     |      ✅     |    
| enable_k8dashboard                  |     ✅    |     ✅     |      -      |      ✅     |    
| enable_registry                     |     -     |     ✅      |      -     |      ✅     |    
| istio_install                       |     ✅    |     ✅     |      ✅     |      ✅     |    
| helm_install                        |     ✅    |     ✅     |      ✅     |      ✅     |    
| certmanager_install                 |     -     |     -      |      -      |       ✅     |    
| certmanager_enable                  |     -     |     -      |      -      |       ✅     |     
| keptn_install                       |     ✅    |     ✅     |      ✅     |      ✅     |    
| keptn_examples_clone                |     ✅    |     ✅     |      ✅     |      ✅     |    
| resources_clone                     |     ✅    |     ✅     |      ✅     |      ✅     |     
| resources_route_istio_ingress       |     ✅    |     ✅     |      ✅     |      ✅     |         
| dynatrace_savecredentials           |     ✅    |     ✅     |      ✅     |      ✅     |     
| dynatrace_configure_monitoring      |     ✅    |     ✅     |      ✅     |      ✅     |     
| dynatrace_activegate_install        |     ✅    |     ✅     |      ✅     |      ✅     |       
| dynatrace_configure_workloads       |     ✅    |     ✅     |      ✅     |      ✅     |     
| keptn_bridge_expose                 |     ✅    |     ✅     |      ✅     |      ✅     |
| keptndemo_teaser_pipeline           |     ✅    |     ✅     |      ✅     |      ✅     |    
| keptndemo_cartsload                 |     ✅    |     ✅     |      -      |      ✅     |    
| keptndemo_unleash                   |     ✅    |     ✅     |      -      |      ✅     |    
| keptndemo_cartsonboard              |     ✅    |     ✅     |      -      |      ✅     |    
| microk8s_expose_kubernetes_api      |     ✅    |     ✅     |      ✅     |      ✅     |    
| microk8s_expose_kubernetes_dashboard|     ✅    |     ✅     |      -      |      ✅     |    
| create_workshop_user                |     -     |     ✅     |      -      |      ✅     |

The **dynatrace_*** control flags will be disabled if you don't enter your Dynatrace credentials.

### The Default Installation Bundle
🧩The default installation bundle is **installationBundleDemo**. You can change installation bundles by commenting them out in the section. 
```bash
# ==================================================
#    ----- Select your installation Bundle -----   #
# ==================================================
# Uncomment for installing only Keptn 
# installationBundleKeptnOnly

# - Comment out if selecting another bundle
installationBundleDemo

```
### Enable or disable specific functionality
You can also override and enable/disable specific modules after you select the installationBundle. For example lets enable the workshop account regardless of the installationBundle we selected.
```bash
# ==================================================
# ---- Enable or Disable specific functions -----  #
# ==================================================
create_workshop_user=true
```

### The Installation function
```bash
# ==================================================
#  ----- Call the Installation Function -----      #
# ==================================================
doInstallation
```
At the end of `keptn-in-a-box.sh` we call the installation function. This function is defined at the end of the `functions.sh` file. This function defines the order in which the different modules are to be executed since they have a chronological dependency. For example, in order to onboard an application we first need to have Keptn installed, and Keptn needs Microk8s installed and so on...

## Execute the script
Duration: 5:00

Yay! now let's see Keptn-in-a-box in action 🤘! 

Now that we understand how it works and we have customized the box as we want, let's trigger the installation.

Run the script with sudo rights and send the process to the background.
```bash
sudo ./keptn-in-a-box.sh &
```

Why run it in the background and where is the output of the program you say? Well, keptn-in-a-box is actually optimized to be executed for non-interactive shells at the initialization of an instance. This is done programatically passing the script as [user data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html) while creating dynatrace environments and spininning multiple instances for each student. This is achieved with the [Dynatrace Rest Tenant Automation](https://github.com/sergiohinojosa/Dynatrace-REST-Tenant-Automation) programm. Yes, we love ❤️ automation 🤖and the customization, creation and configuration of environments and instances is done programatically.

### What happens in the background
The script will clone the keptn-in-a-box repository in the 🏠home directory of the user that executed it. It will execute the functions marked as `true`. The installation will take between 4 and 10 minutes, depending on the amount of features, internet connection speed and computing power available.

### 🔍Inspect the script at runtime
To inspect how the installation is going, type
```bash
less +F /tmp/install.log
```
This will open the installation log and read from the input stream. To exit just type `CTRL + C` and then `quit`.

### Installation complete 🙌
At the end of the installation file you should see something similar

```bash
[Keptn-In-A-Box|INFO] [2020-05-25 10:54:40] |======================================================================
[Keptn-In-A-Box|INFO] [2020-05-25 10:54:40] |============ Installation complete :) ============
[Keptn-In-A-Box|INFO] [2020-05-25 10:54:40] |______________________________________________________________________
[Keptn-In-A-Box|INFO] [2020-05-25 10:54:40] |>->-> It took 8 minutes and 57 seconds <-<-<|
[Keptn-In-A-Box|INFO] [2020-05-25 10:54:40] |>->-> Keptn & Kubernetes Exposed Ingress Endpoints <-<-<|
NAMESPACE      NAME                        HOSTS                                                                                                  ADDRESS     PORTS     AGE
default        kubernetes-api-ingress      api.kubernetes.192-168-0-10.nip.io                                                                   127.0.0.1   80, 443   4m51s
istio-system   istio-ingress               192-168-0-10.nip.io,api.keptn.192-168-0-10.nip.io,bridge.keptn.192-168-0-10.nip.io + 5 more...       127.0.0.1   80, 443   4m50s
kube-system    kubernetes-ingress          kubernetes.192-168-0-10.nip.io                                                                       127.0.0.1   80, 443   4m51s
```

## Access your services and innovate
Duration: 4:00

Let's say we selected the 🧩**installationBundleWorkshop** and we installed keptn-in-a-box in a VM in our home network and the student is `dynatrace` with the password `dynatrace` and the domain is 192-168-0-10.nip.io (for ip 192.168.0.10)

After a shell login
```bash
ssh dynatrace@192-168-0-10.nip.io
```
### 🏠The home directory
List the content of the home directory:
```bash
ls 
examples keptn-in-a-box snap
```
You'll have 3 directories; a clone of the **keptn examples**, a clone of **keptn-in-a-box** repository and the configuration of microk8s in snap.

### 💻 Configured clients
The clients are configured and ready to use `helm`, `istioctl`,`kubectl`, `docker` and `keptn`. 

For example type:
```bash
keptn status
Starting to authenticate
Successfully authenticated
Using a file-based storage for the key because the password-store seems to be not set up.
CLI is authenticated against the Keptn cluster https://api.keptn.192-168-0-10.nip.io
```
to see that keptn is installed and already configured or type

```bash
kubectl get all -n sockshop-dev
```
to list the cart sample pods and services of the development stage. You'll notice that autocomplete is also enabled.

### 💻 Available services
|                        |                                                        |
|------------------------|--------------------------------------------------------|
|**Service**             | **URL**                                                |
|Teaser                  | https://192-168-0-10.nip.io                            |
|Kubernetes Dashb.       | https://kubernetes.192-168-0-10.nip.io                 |
|Kubernetes API          | https://api.kubernetes.192-168-0-10.nip.io             |
|Keptn API (swagger)     | https://api.keptn.192-168-0-10.nip.io/swagger-ui       |
|Keptn Bridge            | https://bridge.keptn.192-168-0-10.nip.io               |
|Unleash                 | https://unleash.unleash-dev.192-168-0-10.nip.io        |
|Carts pipeline overview | https://192-168-0-10.nip.io/pipeline/                  |

The Teaser contains links to most of the available services. You can print also the services by showing the configured ingresses in kubernetes
```bash
kubectl get ing -A
```

###  Continue innovating 🚀

Now that you have your single node Kubernetes Cluster configured and up and running, you are all set to continue your journey to the autonomous cloud. Start typing `kubectl` commands, onboard applications with `keptn`, or maybe create your own **unbreakable pipeline** locally? What about creating your own Keptn Service? Take a look at more [Keptn tutorials](https://tutorials.keptn.sh/).

{{ snippets/community/feedback.md }}



