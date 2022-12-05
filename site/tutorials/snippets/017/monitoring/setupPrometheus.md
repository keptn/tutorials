
## Setup Prometheus Monitoring
Duration: 3:00

After creating a project and service, you can set up Prometheus monitoring and configure scrape jobs using the Keptn CLI.

Keptn doesn't install or manage Prometheus and its components. Users need to install Prometheus and Prometheus Alert manager as a prerequisite. 

* To install the Prometheus and Alert Manager, execute:

    <!-- command -->
    ```
    kubectl create namespace monitoring
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm install prometheus prometheus-community/prometheus --namespace monitoring --wait
    ```


### Execute the following steps to install prometheus-service

* Install prometheus-service using `helm`:
<!-- command -->
```
helm upgrade --install -n keptn prometheus-service https://github.com/keptn-contrib/prometheus-service/releases/download/0.8.6/prometheus-service-0.8.6.tgz --reuse-values --wait
```

<!-- 
bash wait_for_deployment_in_namespace "prometheus-service" "keptn" 
sleep 10
-->
    

* Execute the following command to configure Prometheus and set up the rules for the *Prometheus Alerting Manager*:
<!-- command -->
```
keptn configure monitoring prometheus --project=sockshop --service=carts
```

### Optional: Verify Prometheus setup in your cluster

* To verify that the Prometheus scrape jobs are correctly set up, you can access Prometheus by enabling port-forwarding for the prometheus-service:
<!-- command -->
```
kubectl port-forward svc/prometheus-server 8080:80 -n monitoring
```

Prometheus is then available on [localhost:8080/targets](http://localhost:8080/targets) where you can see the targets for the service:
![Prometheus targets](./assets/prometheus-targets.png")

We are going to add the configuration for our SLIs in terms of an SLI file that maps the _name_ of an indicator to a PromQL statement how to actually query it. Please make sure you are in the correct folder `examples/onboarding-carts`.

### Prometheus SLI provider 

During the evaluation of a quality gate, the Prometheus  provider is required that is implemented by an internal Keptn service, the *prometheus-service*. This service will _fetch the values_ for the SLIs that are referenced in an SLO configuration file.

We are going to add the configuration for our SLIs in terms of an SLI file that maps the _name_ of an indicator to a PromQL statement how to actually query it. Please make sure you are in the correct folder `examples/onboarding-carts`.

<!-- bash cd ../../onboarding-carts -->

<!-- command -->
```
keptn add-resource --project=sockshop --stage=staging --service=carts --resource=sli-config-prometheus.yaml --resourceUri=prometheus/sli.yaml 
```

For your information, the contents of the file are as follows:
```
---
spec_version: '1.0'
indicators:
  response_time_p50: histogram_quantile(0.5, sum by(le) (rate(http_response_time_milliseconds_bucket{handler="ItemsController.addToCart",job="$SERVICE-$PROJECT-$STAGE-canary"}[$DURATION_SECONDS])))
  response_time_p90: histogram_quantile(0.9, sum by(le) (rate(http_response_time_milliseconds_bucket{handler="ItemsController.addToCart",job="$SERVICE-$PROJECT-$STAGE-canary"}[$DURATION_SECONDS])))
  response_time_p95: histogram_quantile(0.95, sum by(le) (rate(http_response_time_milliseconds_bucket{handler="ItemsController.addToCart",job="$SERVICE-$PROJECT-$STAGE-canary"}[$DURATION_SECONDS])))
```
