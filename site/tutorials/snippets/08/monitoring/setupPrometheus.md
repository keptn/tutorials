
## Setup Prometheus Monitoring
Duration: 3:00

After creating a project and service, you can setup Prometheus monitoring and configure scrape jobs using the Keptn CLI. 

To install the *prometheus-service*, execute: 

<!-- command -->
```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-service/release-0.4.0/deploy/service.yaml
```

<!-- 
bash wait_for_deployment_in_namespace "prometheus-service" "keptn" 
bash wait_for_deployment_in_namespace "prometheus-service-monitoring-configure-distributor" "keptn" 
sleep 10
-->
    
Negative
: Please note that a Keptn managed Prometheus will be installed only after executing the next command. At this step, we have only installed the service that is responsible for managing Prometheus.

Execute the following command to install Prometheus and set up the rules for the *Prometheus Alerting Manager*:

<!-- command -->
```
keptn configure monitoring prometheus --project=sockshop --service=carts
```

<!-- bash wait_for_deployment_in_namespace "alertmanager" "monitoring" -->
<!-- bash wait_for_deployment_in_namespace "prometheus-deployment" "monitoring" -->

### Optional: Verify Prometheus setup in your cluster
* To verify that the Prometheus scrape jobs are correctly set up, you can access Prometheus by enabling port-forwarding for the prometheus-service:

    ```
    kubectl port-forward svc/prometheus-service 8080 -n monitoring
    ```

Prometheus is then available on [localhost:8080/targets](http://localhost:8080/targets) where you can see the targets for the service:
![Prometheus targets](./assets/prometheus-targets.png")
