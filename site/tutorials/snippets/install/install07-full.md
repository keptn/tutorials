
## Install Keptn in your cluster
Duration: 5:00

To install the latest release of Keptn in your Kubernetes cluster, execute the `keptn install` command.

```
keptn install --keptn-api-service-type=ClusterIP --use-case=continuous-delivery
```

Positive
: The installation process will take about 3-5 minutes.

Negative
: If the installation fails, please double check that you are logged in to your Azure account with `az login`

### Installation details 

In the Keptn namespace, the following deployments should be found:

```
kubectl get deployments -n keptn

NAME                                             READY   UP-TO-DATE   AVAILABLE   AGE
api-gateway-nginx                                1/1     1            1           2m44s
api-service                                      1/1     1            1           2m44s
bridge                                           1/1     1            1           2m44s
configuration-service                            1/1     1            1           2m44s
eventbroker-go                                   1/1     1            1           2m44s
gatekeeper-service                               1/1     1            1           2m44s
helm-service                                     1/1     1            1           2m44s
helm-service-continuous-deployment-distributor   1/1     1            1           2m44s
jmeter-service                                   1/1     1            1           2m44s
lighthouse-service                               1/1     1            1           2m44s
mongodb                                          1/1     1            1           2m44s
mongodb-datastore                                1/1     1            1           2m44s
remediation-service                              1/1     1            1           2m44s
shipyard-service                                 1/1     1            1           2m44s
```




