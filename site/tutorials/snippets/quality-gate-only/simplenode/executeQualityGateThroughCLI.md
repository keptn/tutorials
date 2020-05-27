## Run Quality Gate through Keptn CLI
Duration: 2:00

We should now have everything in place to let Keptn evaluate our quality gate. The only thing we need to do is ask Keptn to start an evaluation for our service and give it a timeframe. The easiest way to do this is by using the Keptn CLI using the command [keptn send event start-evaluation](https://keptn.sh/docs/0.6.0/reference/cli/commands/keptn_send_event_start-evaluation/)

1. Start the evaluation via the CLI

The following is an example to have Keptn evaluate the last 10 minutes by also adding some labels which will later show up in the Keptns Bridge!

```
keptn send event start-evaluation --project=qgproject --stage=qualitystage --service=evalservice --timeframe=10m --labels=gaterun=1,type=viacli
```

Please explore all other options in the Keptn CLI Documentation for [keptn send event start-evaluation](https://keptn.sh/docs/0.6.0/reference/cli/commands/keptn_send_event_start-evaluation/). You can also specify start and end timestamps or also combine start timestamp with a timeframe.

What will come back as an output is the Keptn Context. Something like:
```
ID of Keptn context: f628eb68-849c-4e77-ab69-a504af34a081
```

2. Query status of the evaluation via the CLI

As the evaluation is an asynchronous process it may take a while until the results are available. We can use that Keptn Context with a call [keptn get event evaluation-done](https://keptn.sh/docs/0.6.0/reference/cli/commands/keptn_get_event_evaluation-done/) to query the status of our request by asking Keptn whether the event evaluation-done is already available for a specific Keptn context.

```
keptn get event evaluation-done --keptn-context=f628eb68-849c-4e77-ab69-a504af34a081
```

While Keptn is still evaluation you will get a message that querying evaluation-done was not yet successful. Once the evalution is complete you will however receive the full evaluation result like this:
```
{"contenttype":"application/json","data":{"deploymentstrategy":"","evaluationdetails":{"indicatorResults":[{"score":0,"status":"fail","targets":[{"criteria":"\u003c=800","targetValue":800,"violated":true},{"criteria":"\u003c=+10%","targetValue":0,"violated":false},{"criteria":"\u003c600","targetValue":600,"violated":true}],"value":{"metric":"rt_svc_p95","success":true,"value":1153.0662}},{"score":0,"status":"fail","targets":[{"criteria":"\u003e20000","targetValue":20000,"violated":true}],"value":{"metric":"throughput_svc","success":true,"value":189}},{"score":2,"status":"pass","targets":[{"criteria":"\u003c=1%","targetValue":1,"violated":false}],"value":{"metric":"error_rate_svc","success":true,"value":0}},{"score":0,"status":"info","targets":null,"value":{"metric":"rt_svc_p50","success":true,"value":0.404}},{"score":0,"status":"fail","targets":[{"criteria":"\u003c=+10%","targetValue":0.7960919999999999,"violated":true},{"criteria":"\u003c=+10%","targetValue":0.7960919999999999,"violated":true}],"value":{"metric":"rt_svc_p90","success":true,"value":111.49150000000942}}],"result":"fail","score":40,"sloFileContent":"Y29tcGFyaXNvbjoKICBhZ2dyZWdhdGVfZnVuY3Rpb246IGF2ZwogIGNvbXBhcmVfd2l0aDogc2luZ2xlX3Jlc3VsdAogIGluY2x1ZGVfcmVzdWx0X3dpdGhfc2NvcmU6IHBhc3MKICBudW1iZXJfb2ZfY29tcGFyaXNvbl9yZXN1bHRzOiAzCmZpbHRlcjogbnVsbApvYmplY3RpdmVzOgotIGtleV9zbGk6IGZhbHNlCiAgcGFzczoKICAtIGNyaXRlcmlhOgogICAgLSA8PSsxMCUKICAgIC0gPDYwMAogIHNsaTogcnRfc3ZjX3A5NQogIHdhcm5pbmc6CiAgLSBjcml0ZXJpYToKICAgIC0gPD04MDAKICB3ZWlnaHQ6IDEKLSBrZXlfc2xpOiBmYWxzZQogIHBhc3M6CiAgLSBjcml0ZXJpYToKICAgIC0gJz4yMDAwMCcKICBzbGk6IHRocm91Z2hwdXRfc3ZjCiAgd2FybmluZzogbnVsbAogIHdlaWdodDogMQotIGtleV9zbGk6IGZhbHNlCiAgcGFzczoKICAtIGNyaXRlcmlhOgogICAgLSA8PTElCiAgc2xpOiBlcnJvcl9yYXRlX3N2YwogIHdhcm5pbmc6CiAgLSBjcml0ZXJpYToKICAgIC0gPD0yJQogIHdlaWdodDogMgotIGtleV9zbGk6IGZhbHNlCiAgcGFzczogbnVsbAogIHNsaTogcnRfc3ZjX3A1MAogIHdhcm5pbmc6IG51bGwKICB3ZWlnaHQ6IDEKLSBrZXlfc2xpOiBmYWxzZQogIHBhc3M6CiAgLSBjcml0ZXJpYToKICAgIC0gPD0rMTAlCiAgc2xpOiBydF9zdmNfcDkwCiAgd2FybmluZzoKICAtIGNyaXRlcmlhOgogICAgLSA8PSsxMCUKICB3ZWlnaHQ6IDEKc3BlY192ZXJzaW9uOiAwLjEuMAp0b3RhbF9zY29yZToKICBwYXNzOiA5MCUKICB3YXJuaW5nOiA3NSUK","timeEnd":"2020-05-25T16:17:28.529Z","timeStart":"2020-05-25T16:07:28.529Z"},"labels":{"gaterun":"1","type":"viacli"},"project":"qgproject","result":"fail","service":"evalservice","stage":"qualitystage","teststrategy":"manual"},"id":"fa8f0c4b-4de7-4a0f-870f-175fdbcd6d33","source":"lighthouse-service","specversion":"0.2","time":"2020-05-25T16:19:29.349Z","type":"sh.keptn.events.evaluation-done","shkeptncontext":"f628eb68-849c-4e77-ab69-a504af34a081"}
```

3. Lets validate quality gate in bridge

If everything works as expected we should be able to see the result in the Keptn's bridge

![](./assets/dynatrace_qualitygates/quality_gate_only_bridge.png)

4. Lets evaluate the event in Dynatrace

Thanks to the Dynatrace integration that also pushes events to Dynatrace we should also see Quality Gate result in Dynatrace when navigating to our sevice.

![](./assets/dynatrace_qualitygates/dynatrace_qualitygateevent.png)