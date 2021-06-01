
## Setup Prometheus Monitoring
Duration: 3:00

After creating a project and service, you can set up Prometheus monitoring and configure scrape jobs using the Keptn CLI. 

Keptn doesn't install or manage Prometheus and its components. Users need to install Prometheus and Prometheus Alert manager as a prerequisite. 

* To install the Prometheus and Alert Manager, execute:
<!-- command -->
```
kubectl create ns monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/prometheus --namespace monitoring
```

### Execute the following steps to install prometheus-service

* Download the Keptn's Prometheus service manifest
<!-- command -->
```
kubectl apply -f  https://raw.githubusercontent.com/keptn-contrib/prometheus-service/release-0.5.0/deploy/service.yaml
```

* Replace the environment variable value according to the use case and apply the manifest
<!-- command -->
```
# Prometheus installed namespace
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" PROMETHEUS_NS="monitoring"

# Alert Manager installed namespace
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" ALERT_MANAGER_NS="monitoring"
```

* Install Role and Rolebinding to permit Keptn's prometheus-service for performing operations in the Prometheus installed namespace.
<!-- command -->
```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-service/release-0.5.0/deploy/role.yaml -n monitoring
```

<!-- 
bash wait_for_deployment_in_namespace "prometheus-service" "keptn" 
bash wait_for_deployment_in_namespace "prometheus-service-monitoring-configure-distributor" "keptn" 
sleep 10
-->
    

* Execute the following command to install Prometheus and set up the rules for the *Prometheus Alerting Manager*:
<!-- command -->
```
keptn configure monitoring prometheus --project=sockshop --service=carts
```

<!-- bash wait_for_deployment_in_namespace "alertmanager" "monitoring" -->
<!-- bash wait_for_deployment_in_namespace "prometheus-deployment" "monitoring" -->

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
keptn add-resource --project=sockshop --stage=staging --service=carts --resource=sli-config-prometheus-bg.yaml --resourceUri=prometheus/sli.yaml 
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