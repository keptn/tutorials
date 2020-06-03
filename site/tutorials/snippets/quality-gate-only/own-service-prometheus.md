
## Bring your own monitored microservice
Duration: 7:00

This tutorial is slightly different compared to others because you need to bring your own monitored service. However, we are helping you here to use our infamous sockshop application with its carts microservice. 

If you want to use your own service, please adopt references to _sockshop_ and _carts_ in the remainder of this tutorial with your own service names. 

Install the Prometheus service in your Keptn installation:

```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-service/release-0.3.3/deploy/service.yaml
```

Deploy the sample application with `kubectl` into your Kubernetes cluster. This part would actually be done by your CI/CD pipeline. However, since we do not have this pipeline at hand, we are doing this manually:

```
kubectl create namespace sockshop-hardening

kubectl apply -f https://raw.githubusercontent.com/keptn/examples/master/onboarding-carts/manifests/manifest-carts-db.yaml
kubectl apply -f https://raw.githubusercontent.com/keptn/examples/master/onboarding-carts/manifests/manifest-carts.yaml
```


Positive
: If you followed the instructions above and are not using your own microservice, you can skip the next part.

This tutorial assumes that you have Prometheus installed and the service has to be monitored by Prometheus. If you are using your own microservice, please make sure that it is properly monitored by Prometheus and a corresponding *scrape job* is in place:

To configure a scrape job for a Prometheus deployed on Kubernetes, you need to update the `prometheus-server-conf` ConfigMap at the `prometheus.yml` section with an additional scrape job:

  ```
  prometheus.yaml:
  ----
  scrape_configs: 
  - job_name: carts-sockshop-hardening
    honor_timestamps: false
    metrics_path: /prometheus
    static_configs:
    - targets:
      - carts.sockshop-hardening:80
  ```

For more information about configuring a scrape job, see the official Prometheus documentation at section [scrape_config](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config). 

