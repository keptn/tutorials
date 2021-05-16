
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

# Prometheus server configmap name
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" PROMETHEUS_CM="prometheus-server"

# Prometheus server app labels
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" PROMETHEUS_LABELS="component=server"

# Prometheus configmap data's config filename
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" PROMETHEUS_CONFIG_FILENAME="prometheus.yml"

# AlertManager configmap data's config filename
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" ALERT_MANAGER_CONFIG_FILENAME="alertmanager.yml"

# Alert Manager config map name
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" ALERT_MANAGER_CM="prometheus-alertmanager"

# Alert Manager app labels
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" ALERT_MANAGER_LABELS="component=alertmanager"

# Alert Manager installed namespace
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" ALERT_MANAGER_NS="monitoring"

# Alert Manager template configmap name
kubectl set env deployment/prometheus-service -n keptn --containers="prometheus-service" ALERT_MANAGER_TEMPLATE_CM="alertmanager-templates"
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
