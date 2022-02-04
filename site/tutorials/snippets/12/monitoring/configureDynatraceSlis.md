## Set up SLI provider
Duration: 2:00

During the evaluation of a quality gate, the dynatrace-service can be used to fetch the values for the SLIs that are referenced in an SLO configuration. In our example, we are going to customize the SLIs made available to Keptn by adding an SLI configuration file.

Prior to executing the next step, please make sure you are in the correct folder `examples/onboarding-carts`. If not, please change the directory accordingly, e.g., with `cd ../../onboarding-carts/`.

Next, add a global SLI configuration file to the project for all services and stages we create.

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
  throughput: "metricSelector=builtin:service.requestCount.total:merge(\"dt.entity.service\"):sum&entitySelector=type(SERVICE),tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
  error_rate: "metricSelector=builtin:service.errors.total.count:merge(\"dt.entity.service\"):avg&entitySelector=type(SERVICE),tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
  response_time_p50: "metricSelector=builtin:service.response.time:merge(\"dt.entity.service\"):percentile(50)&entitySelector=type(SERVICE),tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
  response_time_p90: "metricSelector=builtin:service.response.time:merge(\"dt.entity.service\"):percentile(90)&entitySelector=type(SERVICE),tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
  response_time_p95: "metricSelector=builtin:service.response.time:merge(\"dt.entity.service\"):percentile(95)&entitySelector=type(SERVICE),tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT)"
```

Configure the already onboarded project with the new SLI provider for Keptn to create some needed resources (e.g., a configmap):

<!-- command -->
```
keptn configure monitoring dynatrace --project=sockshop
```
