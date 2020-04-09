
environment:

## Download Keptn CLI
Duration: 2:00

Every release of Keptn provides binaries for the Keptn CLI. These binaries are available for Linux, macOS, and Windows.


1. Download the version for your operating system from [Download CLI](https://github.com/keptn/keptn/releases/tag/0.6.1)
1. Unpack the download
1. Find the `keptn` binary in the unpacked directory

  - *Linux / macOS*: Add executable permissions (``chmod +x keptn``), and move it to the desired destination (e.g. `mv keptn /usr/local/bin/keptn`)

  - *Windows*: Copy the executable to the desired folder and add the executable to your PATH environment variable.

1. Now, you should be able to run the Keptn CLI: 
    - Linux / macOS
      ```console
      keptn --help
      ```
    
    - Windows
      ```console
      .\keptn.exe --help
      ```

**Note:** For the rest of the documentation we will stick to the *Linux / macOS* version of the commands.


## Install Keptn in your cluster
Duration: 7:00

To install the latest release of Keptn on a Kuberntes cluster, execute the [keptn install](../../reference/cli/#keptn-install) command with the ``platform`` flag specifying the target platform you would like to install Keptn on. 



environment:aks

```console
keptn install --platform=aks
```
  
environment:eks

```console
keptn install --platform=eks
```
If you have a custom domain or cannot use *xip.io* (e.g., when running Keptn on EKS with an ELB (Elastic Load Balancer) from AWS), there is the CLI command [keptn configure domain](../../reference/cli/#keptn-configure-domain) to configure Keptn for your custom domain:

```console
keptn configure domain YOUR_DOMAIN
```

environment:gke

```console
keptn install --platform=gke
```

environment:oc

```console
keptn install --platform=openshift
```

environment:pks

```console
keptn install --platform=pks
```

environment:minikube

```console
keptn install --platform=kubernetes
```

### Installation details 

In the Kubernetes cluster, this command creates the **keptn**, **keptn-datastore**, and **istio-system** namespace. While istio-system contains all Istio related resources, keptn and keptn-datastore contain the complete infrastructure to run Keptn. 

### Troubleshooting

Please note that in case of any errors, the install process might leave some files in an inconsistent state. Therefore [keptn install](../../reference/cli/#keptn-install) cannot be executed a second time without [keptn uninstall](../../reference/cli/#keptn-uninstall). To address a unsuccessful installation: 

1. [Verify the Keptn installation](../../reference/troubleshooting#verifying-a-keptn-installation).

1. Uninstall Keptn by executing the [keptn uninstall](../../reference/cli#keptn-uninstall) command before conducting a re-installation.  
