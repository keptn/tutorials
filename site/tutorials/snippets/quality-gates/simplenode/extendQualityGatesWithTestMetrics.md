
## Extend Quality Gates with Test Step Metrics
Duration: 5:00

Our quality gates so far are based on 5 basic metrics: throughput, error rate, response time (p50, p90, p95).
While this is a great start we can do much more!!

Dynatrace gives us the option to extract context information from requests that are executed by test tools. Such context information could be the Test Script Name (load.jmx), Test Scenario Name (fullscenario), Test Step Name (homepage, echo, invoke, version). This information can be passed by the Test Tool using an HTTP Header that can be analyzed by Dynatrace as requests come in. Here is such an example header
```
X-Dynatrace-Test: LTN=performance_build1;LSN=Test Scenario;TSN=homepage;
```

The JMeter test file we uploaded - `load.jmx` has already been adjusted so that it sends these HTTP Headers including information such as Test Step Name (TSN) for every of the 4 test steps it executes: homepage, version, api, invoke

If we want to extend our SLIs with metrics such as "Response Time for Invoke", "Response Time for Homepage" or "Number of backend microservice calls for Invoke" ... we need to do two things
#1: Create Request Attributes that tell Dynatrace to extract these HTTP Header values
#2: Create Calculated Service Metrics that will give us new metrics split by Test Name

The following image shows how this all plays together:
![](./assets/simplenode/loadtestingintegration.png)

Good news is that we can fully automate the configuration of Request Attributes and Calculated Service Metrics through the Dynatrace API. We have two scripts that does this for us. Please make sure you navigate into the *examples\simplenodeservice\dynatrace* folder. Here we execute the following scripts:
```
./createTestRequestAttributes.sh
./createTestStepCalculatedMetrics.sh CONTEXTLESS keptn_project
```

The first script will create but not overwrite the Request Attribute rules for TSN (Test Step Name), LTN (Load Test Name) & LSN (Load Script Name)
The second script will create but not overwrite the following Calculated Service Metrics:


| Name | MetricId |
| --- | --------- |
| Test Step Response Time | calc:service.teststepresponsetime |
| Test Step Service Calls | calc:service.teststepservicecalls |
| Test Step DB Calls | calc:service.teststepdbcalls |
| Test Step Failure Rate | calc:service.teststepfailurerate |
| Test Requests by HTTP Status | calc:service.testrequestsbyhttpstatus |
| Test Step CPU | calc:service.teststepcpu |
| Test Step DB Calls | calc:service.teststepdbcalls |

From now on - everytime Keptn executes these JMeter tests we will have new metrics available that provide a data dimension for each Test Step Name.

This also allows us to extend our SLIs with these metric definitions. In our examples we therefore have a `sli_perftest.yaml` and also a `slo_perftest.yaml` that include these new metrics.
Make sure you navigate to the *examples\simplenodeservice\keptn* directory. Now:

1. First, lets upload our `dynatrace/sli_perftest.yaml` as `dynatrace/sli.yaml` for staging!

We could upload these new sli files with the extended indicators to both staging and production. But - in order to show you that we can have different SLIs and SLOs in each stage we just upload it to staging.

```
keptn add-resource --project=simplenodeproject --stage=staging --service=simplenode --resource=dynatrace/sli_perftest.yaml --resourceUri=dynatrace/sli.yaml
```

Please explore the sli_perftest.yaml file yourself to see the new queries. For reference here are two of the queries that show you how the Dynatrace Metrics API allows us to query calculated service metrics for individual dimensions (e.g: Test Name):

```
  rt_test_version:         "metricSelector=calc:service.teststepresponsetime:filter(eq(Test Step,version)):merge(0):avg&entitySelector=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT),type(SERVICE)"
  rt_test_homepage:        "metricSelector=calc:service.teststepresponsetime:filter(eq(Test Step,homepage)):merge(0):avg&entitySelector=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT),type(SERVICE)"
```

2. Second, lets upload our `slo_perftest.yaml` as `slo.yaml`

Same as with the SLI. We just upload it to the staging as this file now defines objectives for the new indicators defined in the SLI.

```
keptn add-resource --project=simplenodeproject --stage=staging --service=simplenode --resource=slo_perftest.yaml --resourceUri=slo.yaml
```

## Deploy build with extended Test Step Metrics Quality Gate
Duration: 5:00

Let's go back to build 1.0.0 and deploy it again. What we should see is that Keptn will query all these additional test step specific metrics for the quality gate evaluation in staging.

1. Lets deploy build number 1.0.0 again

```
keptn send event new-artifact --project=simplenodeproject --service=simplenode --image=grabnerandi/simplenodeservice --tag=1.0.0
```

2. Lets validate quality gate in bridge:

What you should see are all these new SLIs showing up in the bridge!

![](./assets/simplenode/heatmapwithteststepslis.png)