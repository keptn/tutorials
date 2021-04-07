
## Setup Prometheus Monitoring
Duration: 3:00

After creating a project and service, you can set up Prometheus monitoring and configure scrape jobs using the Keptn CLI. 

Keptn doesn't install or manage Prometheus and its components. Users need to install Prometheus and Prometheus Alert manager as a prerequisite. 

Some environment variables have to set up in the prometheus-service deployment
```yaml
    # Prometheus installed namespace
    - name: PROMETHEUS_NS
      value: 'default'
    # Prometheus server configmap name
    - name: PROMETHEUS_CM
      value: 'prometheus-server'
    # Prometheus server app labels
    - name: PROMETHEUS_LABELS
      value: 'component=server'
    # Prometheus configmap data's config filename
    - name: PROMETHEUS_CONFIG_FILENAME
      value: 'prometheus.yml'
    # AlertManager configmap data's config filename
    - name: ALERT_MANAGER_CONFIG_FILENAME
      value: 'alertmanager.yml'
    # Alert Manager config map name
    - name: ALERT_MANAGER_CM
      value: 'prometheus-alertmanager'
    # Alert Manager app labels
    - name: ALERT_MANAGER_LABELS
      value: 'component=alertmanager'
    # Alert Manager installed namespace
    - name: ALERT_MANAGER_NS
      value: 'default'
    # Alert Manager template configmap name
    - name: ALERT_MANAGER_TEMPLATE_CM
      value: 'alertmanager-templates'
```

### Execute the following steps to install prometheus-service

* Download the Keptn's Prometheus service manifest
<!-- command -->
```bash
wget https://raw.githubusercontent.com/keptn-contrib/prometheus-service/release-0.4.0/deploy/service.yaml
```

* Replace the environment variable value according to the use case and apply the manifest
```bash
kubectl apply -f service.yaml
```

* Install Role and Rolebinding to permit Keptn's prometheus-service for performing operations in the Prometheus installed namespace.
```bash
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-service/release-0.4.0/deploy/role.yaml -n <PROMETHEUS_NS>
```

<!-- 
bash wait_for_deployment_in_namespace "prometheus-service" "keptn" 
bash wait_for_deployment_in_namespace "prometheus-service-monitoring-configure-distributor" "keptn" 
sleep 10
-->
    

* Execute the following command to install Prometheus and set up the rules for the *Prometheus Alerting Manager*:
<!-- command -->
```bash
keptn configure monitoring prometheus --project=sockshop --service=carts
```

<!-- bash wait_for_deployment_in_namespace "alertmanager" "monitoring" -->
<!-- bash wait_for_deployment_in_namespace "prometheus-deployment" "monitoring" -->

### Optional: Verify Prometheus setup in your cluster

* To verify that the Prometheus scrape jobs are correctly set up, you can access Prometheus by enabling port-forwarding for the prometheus-service:
```bash
kubectl port-forward svc/prometheus-service 8080 -n <PROMETHEUS_NS>
```

Prometheus is then available on [localhost:8080/targets](http://localhost:8080/targets) where you can see the targets for the service:
![Prometheus targets](./assets/prometheus-targets.png")
