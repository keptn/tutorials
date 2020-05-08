summary: Keptn Quality Gates with Prometheus
id: keptn-quality-gates-prometheus
categories: prometheus,aks,eks,openshift,pks,minikube,gke,quality-gates
tags: keptn06x
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials


# Keptn Quality Gates with Prometheus

## Welcome
Duration: 5:00

Let's say you want to use your existing tools to deploy and test your applications - you can still use *Keptn`s Quality Gates* for the evaluation of Service Level Objectives (SLOs).

*A brief recap of SLO and SLI:* A Service Level Objective (SLO) is a target value or range of values for a service level that is measured by a Service Level Indicator (SLI). An SLI is a carefully defined quantitative measure of some aspect of the level of service that is provided. By default, the following SLIs can be used for evaluation, inspired by the [Site Reliability Engineering](https://landing.google.com/sre/sre-book/chapters/service-level-objectives) book from Google:

* *Response time*: The time it takes for a service to execute and complete a task or how long it takes to return a response to a request.
* *System throughput*: The number of requests per second that have been processed.
* *Error rate*: The fraction of all received requests that produced an error.

Positive
: For more information about SLO and SLI, please take a look at [Specifications for Site Reliability Engineering with Keptn](https://github.com/keptn/spec/blob/0.1.3/sre.md).

### What you'll learn

- Learn how to define and use service-level indicators (SLIs) and service-level objectives (SLOs)
- Integrate Keptn Quality Gates in your existing CI/CD pipeline
- How to use the Keptn CLI to trigger the quality gate evaluation
- How to use the Keptn API to trigger the quality gate evaluation

## Prerequisites for tutorial
Duration: 4:00


Clone the following tutorial to your local machine to have all files at hand that we are going to use for this tutorial.

```
git clone --branch release-0.6.2 https://github.com/keptn/examples.git --single-branch

cd examples/onboarding-carts 
```

Negative
: For this tutorial you have to bring your own microservice to deploy, test and evaluate. This tutorial uses a service called carts from the project sockshop meaning that you must adapt the commands to match your service and project name.


<!-- include snippets here -->
## Bring your Kubernetes cluster
Duration: 10:00

For this tutorial a Kubernetes cluster is needed. Please take a look a the [different cluster installations](https://tutorials.keptn.sh/?cat=installation) we are providing.


{{ snippets/install/download-keptnCLI.md }}

{{ snippets/install/kqg-install.md }}

{{ snippets/quality-gate-only/own-service-prometheus.md }}

{{ snippets/quality-gate-only/configure-keptn.md }}

{{ snippets/monitoring/install-sliprovider-prometheus.md }}

## Configure the SLI provider
Duration: 3:00

Configure custom SLIs for the Prometheus SLI provider as specified in `sli-config-prometheus.yaml`:

```
keptn add-resource --project=sockshop --stage=hardening --service=carts --resource=sli-config-prometheus.yaml --resourceUri=prometheus/sli.yaml
```

This will add service-level indicator to your Keptn installation which can be used in our quality-gate file `slo.yaml` where we defined objectives upon those metrics:

```
---
spec_version: '1.0'
indicators:
  response_time_p50: histogram_quantile(0.5, sum by(le) (rate(http_response_time_milliseconds_bucket{handler="ItemsController.addToCart",job="$SERVICE-$PROJECT-$STAGE"}[$DURATION_SECONDS])))
  response_time_p90: histogram_quantile(0.9, sum by(le) (rate(http_response_time_milliseconds_bucket{handler="ItemsController.addToCart",job="$SERVICE-$PROJECT-$STAGE"}[$DURATION_SECONDS])))
  response_time_p95: histogram_quantile(0.95, sum by(le) (rate(http_response_time_milliseconds_bucket{handler="ItemsController.addToCart",job="$SERVICE-$PROJECT-$STAGE"}[$DURATION_SECONDS])))
```

## Quality Gates in action
Duration: 1:00

At this point, your service is ready and you can now start triggering evaluations of the SLO. A quality gate is a two-step procedure that consists of starting the evaluation and polling for the results.

At a specific point in time, e.g., after you have executed your tests or you have waited for enough live traffic, you can either start the evaluation of a quality gate manually using the Keptn CLI, or automate it by either including the Keptn CLI calls in your automation scripts, or by directly accessing the Keptn REST API.

Positive
: We will use both the Keptn CLI as well as the Keptn API for the evaluation of the quality gates.

## Quality Gate evaluation with Keptn CLI
Duration: 5:00

Execute a quality gate evaluation by using the Keptn CLI to [send event start-evaluation](https://keptn.sh/docs/0.6.0/reference/cli/#keptn-send-event-start-evaluation): 

```
keptn send event start-evaluation --project=sockshop --stage=hardening --service=carts --timeframe=5m
```

This `start-evaluation` event will kick off the evaluation of the SLO of the catalogue service over the last 5 minutes. Evaluations can be done in seconds but may also take a while as every SLI provider needs to query each SLI first. This is why the Keptn CLI will return the `keptnContext`, which is basically a token we can use to poll the status of this particular evaluation. The output of the previous command looks like this:

```
Starting to send a start-evaluation event to evaluate the service catalogue in project sockshop
ID of Keptn context: 6cd3e469-cbd3-4f73-xxxx-8b2fb341bb11
```

* Retrieve the evaluation results by using the Keptn CLI to [get event evaluation-done](https://keptn.sh/docs/0.6.0/reference/cli/#keptn-get-event-evaluation-done): 
    
```
keptn get event evaluation-done --keptn-context=6cd3e469-cbd3-4f73-xxxx-8b2fb341bb11
```

The result comes in the form of the `evaluation-done` event, which is specified [here](https://github.com/keptn/spec/blob/0.1.3/cloudevents.md#evaluation-done).


## Quality Gate evaluation with Keptn API
Duration: 5:00

First, get the Keptn API endpoint and token by executing the following commands: 

```
KEPTN_ENDPOINT=https://api.keptn.$(kubectl get cm keptn-domain -n keptn -ojsonpath={.data.app_domain})

# now print the endpoint and token to the local console
echo $KEPTN_ENDPOINT
echo $(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
```

Prepare the POST request body by filling out the next JSON object: 

```
{
  "type": "sh.keptn.event.start-evaluation",
  "source": "https://github.com/keptn/keptn"
  "data": {
    "start": "2020-04-21T11:00:00.000Z",
    "end": "2020-04-21T11:05:00.000Z",
    "project": "sockshop",
    "stage": "hardening",
    "service": "carts",
    "teststrategy": "manual"
  }
}
```

Please take attention that the above CloudEvent contains the property `"teststrategy": "manual"`. This is required to tell Keptn that a test had been manually executed; meaning that a test had been triggered by a tool other than Keptn. 

Negative
: Please note that the start and end time has to be changed to reflect the time frame you want to evaluate!

Execute a quality gate evaluation by sending a POST request with the Keptn API token and the prepared payload:

```
curl -X POST "https://api.keptn.12.34.56.78.xip.io/v1/event" -k -H "accept: application/json" -H "x-token: YOUR_KEPTN_TOKEN" -H "Content-Type: application/json" -d "{ \"data\": { \"end\": \"2019-11-21T11:05:00.000Z\", \"project\": \"sockshop\", \"service\": \"carts\", \"stage\": \"hardening\", \"start\": \"2019-11-21T11:00:00.000Z\", \"teststrategy\": \"manual\" }, \"type\": \"sh.keptn.event.start-evaluation\", \"source\": \"https://github.com/keptn/keptn\"}"
```

This request will kick off the evaluation of the SLO of the catalogue service over the last 5 minutes. Evaluations can be done in seconds but may also take a while as every SLI provider needs to query each SLI first. This is why the Keptn API will return the `keptnContext`, which is basically a token we can use to poll the status of this particular evaluation. The response to the POST request looks like this:

```
{"keptnContext":"384dae76-2d31-41e6-9204-39f2c1513906","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDU0NDA4ODl9.OdkhIoJ9KuT4bm7imvEXHdEPjnU0pl5S7DqGibNa924"}
```

Send a GET request to retrieve the evaluation result: 

```
curl -X GET "https://api.keptn.12.34.56.78.xip.io/v1/event?keptnContext=KEPTN_CONTEXT_ID&type=sh.keptn.events.evaluation-done" -k -H "accept: application/json" -H "x-token: YOUR_KEPTN_TOKEN"
```

The result comes in the form of the `evaluation-done` event, which is specified [here](https://github.com/keptn/spec/blob/0.1.3/cloudevents.md#evaluation-done).


## Quality Gate evaluation verification with Keptn's Bridge
Duration: 5:00

The Keptn's bridge gives you insights about everything that is going on inside your Keptn installation, thus, you can also verify the evaluation of the quality gates. By default, the Keptn's bridge is not exposed to the public, but you can expose it via:

```
kubectl port-forward svc/bridge -n keptn 8080
```

Open up a brower on http://localhost:8080 and you will be able to inspect all evaluations of the quality gates in the Keptn's bridge.

![bridge](./assets/kqg-bridge-prometheus.png)

## Try with more deployments
Duration: 1:00

You can now go ahead and deploy other versions of the application, send some traffic to it and do another evaluation of the quality gates.
For the `carts` microservice, there are 3 different versions prepared to use:
- Version 0.11.1 no slowdown, no failure rate built in
- Version 0.11.2 slowdown of 1sec built in
- Version 0.11.3 no slowdown, no failure rate built in

You can deploy the different versions by changing it in the `manifests/manifest-carts.yaml` and applying the file.



## Finish
Duration: 0:00

In this tutorial, you have learned how to use Keptn to validate the quality of your deployments.

### What we've covered

- How to define and use service-level objectives (SLOs) based on service-level indicators (SLIs) 
  ```
  ---
  spec_version: "0.1.1"
  comparison:
    aggregate_function: "avg"
    compare_with: "single_result"
    include_result_with_score: "pass"
    number_of_comparison_results: 1
  filter:
  objectives:
    - sli: "response_time_p95"
      key_sli: false
      pass:             # pass if (relative change <= 10% AND absolute value is < 600ms)
        - criteria:
            - "<=+10%"  # relative values require a prefixed sign (plus or minus)
            - "<600"    # absolute values only require a logical operator
      warning:          # if the response time is below 800ms, the result should be a warning
        - criteria:
            - "<=800"
      weight: 1
  total_score:
    pass: "90%"
    warning: "75%"

  ```

- How to use the Keptn CLI to trigger the quality gate evaluation
  ```
  keptn send event start-evaluation --project=sockshop --stage=hardening --service=carts --timeframe=5m

  keptn get event evaluation-done --keptn-context=6cd3e469-cbd3-4f73-xxxx-8b2fb341bb11
  ```
- How to use the Keptn API to trigger the quality gate evaluation
  ```
  curl -X POST "https://api.keptn.12.34.56.78.xip.io/v1/event" -k -H "accept: application/json" -H "x-token: YOUR_KEPTN_TOKEN" -H "Content-Type: application/json" -d "{ \"data\": { \"end\": \"2019-11-21T11:05:00.000Z\", \"project\": \"sockshop\", \"service\": \"carts\", \"stage\": \"hardening\", \"start\": \"2019-11-21T11:00:00.000Z\", \"teststrategy\": \"manual\" }, \"type\": \"sh.keptn.event.start-evaluation\", \"source\": \"https://github.com/keptn/keptn\"}"
 
  curl -X GET "https://api.keptn.12.34.56.78.xip.io/v1/event?keptnContext=KEPTN_CONTEXT_ID&type=sh.keptn.events.evaluation-done" -k -H "accept: application/json" -H "x-token: YOUR_KEPTN_TOKEN"
  ```
- How to use the Keptn's Bridge to inspect quality gate evaluations
  ![bridge](./assets/kqg-bridge-prometheus.png)
  