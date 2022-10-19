
## Install Keptn in your cluster
Duration: 5:00

To install the latest release of Keptn with full _quality gate + continuous delivery capabilities_ in your Kubernetes cluster, execute the `helm install` command.

```
helm install keptn --version 0.18.0 -n keptn --repo=https://charts.keptn.sh --create-namespace --wait --set=continuousDelivery.enabled=true --generate-name
```

<!-- bash verify_test_step $? "keptn install failed" -->

Positive
: The installation process will take about 3-5 minutes.

Positive
: Please note that Keptn comes with different installation options, all of the described in detail in the [Keptn docs](https://keptn.sh/docs/install/).

### Install the execution plane components
These are additional microservices that will handle certain tasks

```
helm install jmeter-service keptn/jmeter-service -n keptn
helm install helm-service keptn/helm-service -n keptn
```

### Installation details 

By default Keptn installs into the `keptn` namespace. Once the installation is complete we can verify the deployments:

<!-- command -->
```
kubectl get deployments -n keptn
```

Here is the output of the command:

```
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
api-gateway-nginx             1/1     1            1           2m44s
api-service                   1/1     1            1           2m44s
approval-service              1/1     1            1           2m44s
bridge                        1/1     1            1           2m44s
resource-service              1/1     1            1           2m44s
helm-service                  1/1     1            1           2m44s
jmeter-service                1/1     1            1           2m44s
lighthouse-service            1/1     1            1           2m44s
litmus-service                1/1     1            1           2m44s
keptn-mongo                   1/1     1            1           2m44s
mongodb-datastore             1/1     1            1           2m44s
remediation-service           1/1     1            1           2m44s
shipyard-controller           1/1     1            1           2m44s
statistics-service            1/1     1            1           2m44s
webhook-service               1/1     1            1           2m51s
```




