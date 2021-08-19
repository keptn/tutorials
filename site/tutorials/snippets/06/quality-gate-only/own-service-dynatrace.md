
## Bring your own monitored microservice
Duration: 7:00

This tutorial is slightly different compared to others because you need to bring your own monitored service. However, we are helping you here to use our infamous sockshop application with its carts microservice. 

If you want to use your own service, please adopt references to _sockshop_ and _carts_ in the remainder of this tutorial with your own service names. 

Before we are going to deploy the service, let us setup Dynatrace to be able to monitor the service. This step is not be necessary if you already have your service monitored by Dynatrace.

TODO: should we install dynatrace here or go with the approach that this has to be brought by the user???

Deploy the sample application with `kubectl` into your Kubernetes cluster. This part would actually be done by your CI/CD pipeline. However, since we do not have this pipeline at hand, we are doing this manually:

```
kubectl apply -f TODO-v1.yaml
```


Positive
: If you followed the instructions above and are not using your own microservice, you can skip the next part.


In order for Keptn to extract monitoring data of your specific service it is recommended that you tag your services in Dynatrace in a way that the tags uniquely identify your services. The Keptn best practice is to put a tag for project, stage and service.

Please consult the Dynatrace documentation on [Tags and Metadata](https://www.dynatrace.com/support/help/how-to-use-dynatrace/tags-and-metadata/) to learn more about manual or automated tagging and how to create three automated tagging rules named **keptn_project**, **keptn_stage**, and **keptn_service** that extract the respective metadata from the passed environment variable 
