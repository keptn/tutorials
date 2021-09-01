
## Install Keptn in your cluster
Duration: 5:00

To install the latest release of Keptn with full _quality gate + continuous delivery capabilities_ in your Kubernetes cluster, execute the `keptn install` command.

<!-- bash 
echo "{}" > creds.json
 
keptn install --endpoint-service-type=ClusterIP --use-case=continuous-delivery -c ./creds.json
-->

```
keptn install --endpoint-service-type=ClusterIP --use-case=continuous-delivery
```

<!-- bash verify_test_step $? "keptn install failed" -->

Positive
: The installation process will take about 3-5 minutes.

Positive
: Please note that Keptn comes with different installation options, all of the described in detail in the [Keptn docs](https://keptn.sh/docs/0.9.x/operate/install/).

### Installation details 

In the Keptn namespace, the following deployments should be found:

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
configuration-service         1/1     1            1           2m44s
helm-service                  1/1     1            1           2m44s
jmeter-service                1/1     1            1           2m44s
lighthouse-service            1/1     1            1           2m44s
litmus-service                1/1     1            1           2m44s
mongodb                       1/1     1            1           2m44s
mongodb-datastore             1/1     1            1           2m44s
remediation-service           1/1     1            1           2m44s
shipyard-controller           1/1     1            1           2m44s
statistics-service            1/1     1            1           2m44s
```




