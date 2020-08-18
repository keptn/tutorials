
## Set up a basic quality gate
Duration: 4:00

Keptn Quality Gates are based on the concepts of 
* SLIs (Service Level Indicators): what metrics (=indicators) are important and how do we query them
* SLOs (Service Level Objectives): what conditions (=objectives) must be met to consider this a good or a bad value per indicator

In Keptn we therefore need to provide an `sli.yaml` that defines how to query certain metrics from a specific tool, e.g: Dynatrace. We also need to provide an `slo.yaml` that defines the conditions - this file is tool independant. 
To learn more about the *sli.yaml* and *slo.yaml* files, go to [Specifications for Site Reliability Engineering with Keptn](https://github.com/keptn/spec/blob/0.1.3/sre.md).

Our example comes with a basic and an extended set of SLIs and SLOs. In this step we focus on the basic version.
We have to upload two files using the [add-resource](https://keptn.sh/docs/0.7.x/reference/cli/#keptn-add-resource) command.
Ensure you navigate to the `examples/simplenode/keptn` folder.

1. First, lets upload our `dynatrace/sli_basic.yaml` as `dynatrace/sli.yaml`!

```
keptn add-resource --project=simplenodeproject --stage=staging --service=simplenode --resource=dynatrace/sli_basic.yaml --resourceUri=dynatrace/sli.yaml
```

This Dynatrace specific SLI contains the definition of 5 indicators. Each indicator has a logical name, e.g: throughput and the tool specific query, e.g: Dynatrace Metrics Query. You can also see that the query definition can leverage placeholders such as $PROJECT, $SERVICE, $STAGE ... - this is great as we can use them to filter on exactly those services managed by Keptn as long as these tags are put on the Dynatrace entities:
```
---
spec_version: '1.0'
indicators:
  throughput:        "metricSelector=builtin:service.requestCount.total:merge(0):sum&entitySelector=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT),type(SERVICE)"
  error_rate:        "metricSelector=builtin:service.errors.total.rate:merge(0):avg&entitySelector=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT),type(SERVICE)"
  response_time_p50: "metricSelector=builtin:service.response.time:merge(0):percentile(50)&entitySelector=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT),type(SERVICE)"
  response_time_p90: "metricSelector=builtin:service.response.time:merge(0):percentile(90)&entitySelector=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT),type(SERVICE)"
  response_time_p95: "metricSelector=builtin:service.response.time:merge(0):percentile(95)&entitySelector=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT),type(SERVICE)"
```

2. Second, lets upload our `slo_basic.yaml` as `slo.yaml`

```
keptn add-resource --project=simplenodeproject --stage=staging --service=simplenode --resource=slo_basic.yaml --resourceUri=slo.yaml
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

## Adding Basic Tests for Quality Gate
Duration: 3:00

Uploading SLIs & SLOs alone is not enough. What we need are some tests, e.g: simple API performance tests that get executed by Keptn. After those tests are executed Keptn will evaluate the SLIs/SLOs for the timeframe of the test execution.

Keptn comes with a JMeter-Service that can execute JMeter tests when a new deployment happened. In our tutorial we are however using the JMeter-Extended-Service as it gives us some more flexibilty with different workloads. 
1. We simply "upgrade" from JMeter-Service to JMeter-Extended-Service by replacing the image:

```
kubectl -n keptn set image deployment/jmeter-service jmeter-service=keptncontrib/jmeter-extended-service:0.1.0
```

Now we are ready to upload a test script and workload configuration for our staging stage. Ensure you navigate to the `examples/simplenode/keptn` folder.
2. Add load test script & workload config to our staging stage
```
keptn add-resource --project=simplenodeproject --stage=staging --service=simplenode --resource=jmeter/load.jmx --resourceUri=jmeter/load.jmx
```

```
keptn add-resource --project=simplenodeproject --stage=staging --service=simplenode --resource=jmeter/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml
```

## Deploy first build with Tests & Quality Gates
Duration: 5:00

As we have now uploaded tests, SLIs & SLOs we can run the same artifact of version 1.0.0 through the delivery pipeline. The difference now is that Keptn will automatically execute tests in staging and then evaluates our indicators (specified in SLI.yaml) against our objectives (specified in SLO.yaml) for the timeframe of the test execution.

1. Lets deploy build number 1.0.0 again

```
keptn send event new-artifact --project=simplenodeproject --service=simplenode --image=grabnerandi/simplenodeservice --tag=1.0.0
```

2. Lets validate quality gate in bridge:

Remember - this time the deployment will take a bit longer as the tests take about 2-3 minutes to run before Keptn can pull in metrics from Dynatrace. Overall a deployment will now take about 5 minutes. Go back to the Keptn's Bridge and watch for the new events coming in. In a couple of minutes you will also see the evaluation results of your Quality Gate. Lets hope all is green and the build makes it all the way into production :-)

![](./assets/simplenode/firstdeployment_with_qg_bridge.png)

