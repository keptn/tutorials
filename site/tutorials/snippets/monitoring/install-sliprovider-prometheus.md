
## Setup Prometheus SLI provider 
Duration: 2:00

During the evaluation of a quality gate, the Prometheus SLI provider is required that is implemented by an internal Keptn service, the *prometheus-sli-service*. This service will _fetch the values_ for the SLIs that are referenced in an SLO configuration file.

To install the *prometheus-sli-service*, execute:

```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-sli-service/0.2.2/deploy/service.yaml
```
