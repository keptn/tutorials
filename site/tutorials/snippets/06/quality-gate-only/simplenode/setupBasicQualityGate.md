
## Set up a basic quality gate for evalservice
Duration: 4:00

Keptn Quality Gates are based on the concepts of 
* SLIs (Service Level Indicators): what metrics (=indicators) are important and how do we query them
* SLOs (Service Level Objectives): what conditions (=objectives) must be met to consider this a good or a bad value per indicator

In Keptn we therefore need to provide an `sli.yaml` that defines how to query certain metrics from a specific tool, e.g: Dynatrace. We also need to provide an `slo.yaml` that defines the conditions - this file is tool independent. 
To learn more about the *sli.yaml* and *slo.yaml* files, go to [Specifications for Site Reliability Engineering with Keptn](https://github.com/keptn/spec/blob/0.1.3/sre.md).

Our example comes with a basic and an extended set of SLIs and SLOs. In this step we focus on the basic version.
We have to upload two files using the [add-resource](https://keptn.sh/docs/0.6.0/reference/cli/#keptn-add-resource) command.
Ensure you navigate to the `examples/simplenodeservice/quality-gate-only` folder.

1. First, lets upload our `dynatrace/sli_basic.yaml` as `dynatrace/sli.yaml`!

```
keptn add-resource --project=qgproject --stage=qualitystage --service=evalservice --resource=dynatrace/sli_basic.yaml --resourceUri=dynatrace/sli.yaml
```

This Dynatrace specific SLI contains the definition of 5 indicators. Each indicator has a logical name, e.g: throughput and the tool specific query, e.g: Dynatrace Metrics Query. You can also see that the query definition can leverage placeholders such as $SERVICE (there are more of course). In our case - because we keep it really simply we only use the $SERVICE placeholder telling Keptn to only query data from those SERVICE entities that have a tag applied with the name of our Keptn Service. This will be *evalservice*:
```
---
spec_version: '1.0'
indicators:
  throughput_svc: "metricSelector=builtin:service.requestCount.total:merge(0):sum&entitySelector=tag($SERVICE),type(SERVICE)"
  error_rate_svc: "metricSelector=builtin:service.errors.total.rate:merge(0):avg&entitySelector=tag($SERVICE),type(SERVICE)"
  rt_svc_p50:     "metricSelector=builtin:service.response.time:merge(0):percentile(50)&entitySelector=tag($SERVICE),type(SERVICE)"
  rt_svc_p90:     "metricSelector=builtin:service.response.time:merge(0):percentile(90)&entitySelector=tag($SERVICE),type(SERVICE)"
  rt_svc_p95:     "metricSelector=builtin:service.response.time:merge(0):percentile(95)&entitySelector=tag($SERVICE),type(SERVICE)"
```

2. Second, lets upload our `slo_basic.yaml` as `slo.yaml`

```
keptn add-resource --project=qgproject --stage=qualitystage --service=evalservice --resource=slo_basic.yaml --resourceUri=slo.yaml
```

This `slo.yaml` defines the objectives and references the SLIs defined in the `sli.yaml`:

```
---
spec_version: '0.1.0'
comparison:
  compare_with: "single_result"
  include_result_with_score: "pass"
  aggregate_function: avg
objectives:
  - sli: response_time_p95
    pass:        # pass if (relative change <= 10% AND absolute value is < 500)
      - criteria:
          - "<=+10%" # relative values require a prefixed sign (plus or minus)
          - "<600"   # absolute values only require a logical operator
    warning:     # if the response time is below 800ms, the result should be a warning
      - criteria:
          - "<=800"
  - sli: throughput
    pass:
      - criteria:
        - ">4000"
  - sli: error_rate
    weight: 2
    pass:
      - criteria:
          - "<=1%"
    warning:
      - criteria:
          - "<=2%"
  - sli: response_time_p50
  - sli: response_time_p90
    pass:
      - criteria:
          - "<=+10%"
    warning:
      - criteria:
          - "<=+10%"
total_score:
  pass: "90%"
  warning: "75%"
```

## Dynatrace Event Configuration
Duration: 1:00

Keptn not only provides an integration with Dynatrace to pull SLIs. It also provides an integration where Keptn can push events to Dynatrace, e.g: when a Quality Gate was evaluated it can send that information to a specific set of Dynatrace entities by leveraging the Dynatrace Events API.
By default the Dynatrace Keptn Service assumes that monitored services in Dynatrace are deployed by Keptn and therefore tagged with 4 specific tags: keptn_project, keptn_service, keptn_stage & keptn_deployment. In a scenario where Keptn doesnt manage the deployment we cannot assume these tags are there. This is why we have to tell the Dynatrace Keptn Service to which entities the events should be sent to. This configuration can be provided by uploading a *dynatrace.conf.yaml* which includes the actual tag rules. In our case its very simply. First the command to upload the dynatrace.conf.yaml:

```
keptn add-resource --project=qgproject --stage=qualitystage --service=evalservice --resource=dynatrace/dynatrace.conf.yaml --resourceUri=dynatrace/dynatrace.conf.yaml
```

And here is the content that is in there - showing you that you can use the Keptn to Dynatrace integration to let Keptn send events to any type of monitored service - not only those that are deployed by Keptn:

```
---
spec_version: '0.1.0'
dtCreds: dynatrace
attachRules:
  tagRule:
  - meTypes:
    - SERVICE
    tags:
    - context: CONTEXTLESS
      key: $SERVICE
```
