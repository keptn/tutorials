
## Setup Prometheus SLI provider 
Duration: 2:00

During the evaluation of a quality gate, the Prometheus SLI provider is required that is implemented by an internal Keptn service, the *prometheus-sli-service*. This service will _fetch the values_ for the SLIs that are referenced in an SLO configuration file.

To install the *prometheus-sli-service*, execute:

<!-- command -->
```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-sli-service/release-0.2.2/deploy/service.yaml
```

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
  response_time_p50: histogram_quantile(0.5, sum by(le) (rate(http_response_time_milliseconds_bucket{handler="ItemsController.addToCart",job="$SERVICE-$PROJECT-$STAGE"}[$DURATION_SECONDS])))
  response_time_p90: histogram_quantile(0.9, sum by(le) (rate(http_response_time_milliseconds_bucket{handler="ItemsController.addToCart",job="$SERVICE-$PROJECT-$STAGE"}[$DURATION_SECONDS])))
  response_time_p95: histogram_quantile(0.95, sum by(le) (rate(http_response_time_milliseconds_bucket{handler="ItemsController.addToCart",job="$SERVICE-$PROJECT-$STAGE"}[$DURATION_SECONDS])))
```
