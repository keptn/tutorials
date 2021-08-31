
## Set up a quality gate in production
Duration: 1:00

So far we have uploaded our test script, test workload and our SLI & SLO for our staging stage.
If we also want a quality gate to be enforced after a blue/green deployment is done to production to validate if the production deployment is good enough or whether the Blue/Green deployment should be reverted back we have to add SLI.yaml, SLO.yaml and our tests for production as well.

1. First, lets upload our `dynatrace/sli_basic.yaml` as `dynatrace/sli.yaml` for prod!

We could upload a different sli.yaml for production than the one we have for staging. In a real scenario you probably want this as you may want to include additional indicators from other parts of the infrastructure that you didnt have available in staging. For our sample we just use the same `sli_basic.yaml`!

```
keptn add-resource --project=simplenodeproject --stage=prod --service=simplenode --resource=dynatrace/sli_basic.yaml --resourceUri=dynatrace/sli.yaml
```

If you wonder - how can the same SLI be working in production? Well - its because the SLI is leveraging the placeholders such as $STAGE. Once Keptn will evaluate the SLIs for production this value will be replaced with `prod`. And - as long as all services are correctly tagged in Dynatrace with e.g: `keptn_stage:prod` we are all good.

Here is one of the indicator definitions of this SLI file so you see what I mean:

```
indicators:
  throughput:        "metricSelector=builtin:service.requestCount.total:merge(0):sum&entitySelector=tag(keptn_project:$PROJECT),tag(keptn_stage:$STAGE),tag(keptn_service:$SERVICE),tag(keptn_deployment:$DEPLOYMENT),type(SERVICE)"
```

2. Second, lets upload our `slo_basic.yaml` as `slo.yaml`

Same as with the SLI. We could upload a different SLO that includes different objectives for production, e.g: you may expect different load behavior or you have different hardware your system runs on. In that case you would adjust the SLOs to reflect what you expect in production. For our sample we just take the same SLO that we used for staging

```
keptn add-resource --project=simplenodeproject --stage=prod --service=simplenode --resource=slo_basic.yaml --resourceUri=slo.yaml
```

3. Third, lets upload our tests

In order for the quality gates to evaluate a representative timeframe with representative load we will upload tests to production. This will make sure that after Keptn deploys the artifact in production that these tests get executed against the new Blue/Green deployment. After that the quality gate kicks in. If the validation succeeds Keptn will keep the new build - otherwise it will roll back.
We will use the same test scripts as in staging. We could use different tests - but - for our example that's good enough!

```
keptn add-resource --project=simplenodeproject --stage=prod --service=simplenode --resource=jmeter/load.jmx --resourceUri=jmeter/load.jmx
keptn add-resource --project=simplenodeproject --stage=prod --service=simplenode --resource=jmeter/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml
```
