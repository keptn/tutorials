
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

