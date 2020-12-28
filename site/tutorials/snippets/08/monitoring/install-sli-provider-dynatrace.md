## Setup SLI provider
Duration: 2:00

During the evaluation of a quality gate, the Dynatrace SLI provider is required that is implemented by an internal Keptn service, the dynatrace-sli-service. This service will fetch the values for the SLIs that are referenced in an SLO configuration.

<!-- command -->
```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-sli-service/0.8.0-alpha/deploy/service.yaml -n keptn
```

Next we are going to add an SLI configuration file for Keptn to know how to retrieve the data.
Please make sure you are in the correct folder that is `examples/onboarding-carts`. If not, please change the directory accordingly, e.g., with `cd ../../onboarding-carts/`. We are going to add it globally to the project for all services and stages we create.

<!-- bash cd ../../onboarding-carts/ -->

<!-- command -->
```
keptn add-resource --project=sockshop --resource=sli-config-dynatrace.yaml --resourceUri=dynatrace/sli.yaml
```

For your information, this is what the file looks like:
```
---
spec_version: '1.0'
indicators:
  throughput: "builtin:service.requestCount.total:merge(0):sum?scope=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
  error_rate: "builtin:service.errors.total.count:merge(0):avg?scope=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
  response_time_p50: "builtin:service.response.time:merge(0):percentile(50)?scope=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
  response_time_p90: "builtin:service.response.time:merge(0):percentile(90)?scope=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
  response_time_p95: "builtin:service.response.time:merge(0):percentile(95)?scope=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
```

Configure the already onboarded project with the new SLI provider for Keptn to create some needed resources (e.g., a configmap):

<!-- command -->
```
keptn configure monitoring dynatrace --project=sockshop
```

Positive
: Since we already installed the Dynatrace service, the SLI provider can fetch the credentials to connect to Dynatrace from the same secret we created earlier.
