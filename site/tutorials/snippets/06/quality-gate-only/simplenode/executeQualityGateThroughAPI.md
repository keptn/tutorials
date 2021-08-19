## Run Quality Gate through Keptn API
Duration: 2:00

After we have executed the Quality Gate Evaluation through the CLI lets do the same through the [Keptn API](https://keptn.sh/docs/0.6.0/reference/api/).
If you read through the [Keptn API documentation](https://keptn.sh/docs/0.6.0/reference/api/) you learn we have to get the API Endpoint and the Token first!

1. Get API Endpoint

Keptn status gives us the endpoint:

```
$ keptn status
Starting to authenticate
Successfully authenticated
Using a file-based storage for the key because the password-store seems to be not set up.      
CLI is authenticated against the Keptn cluster https://api.YOURKEPTNDOMAIN
```

2. Retrieving API Token

In order to retrieve the API token we need access to kubectl. There is an easy and convenient way described in the [Keptn CLI Authentication documentation](https://keptn.sh/docs/0.6.0/reference/cli/#authentication) to actually retrieve and store both the API Endpoint and API Token in a variable. This helps us later on to automate API calls as well. So - lets do it!
```
KEPTN_ENDPOINT=https://api.keptn.$(kubectl get cm keptn-domain -n keptn -ojsonpath='{.data.app_domain}')
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath='{.data.keptn-api-token}' | base64 --decode)
```

3. Explore the Keptn API via Swagger UI

If you want to make yourself familiar with all options of the API you can browse to your api endpoint and explore the Swagger UI by adding /swagger-ui to the API Endpoint, e.g: https://api.YOURKEPTNDOMAIN/swagger-ui

4. Send a start-evaluation event

The easiest way to make API calls is through the Swagger UI. In order to use it we first need to authorize the Swagger UI by giving it our API token. To get the actual value do:
```
echo $KEPTN_API_TOKEN
```

Copy that value, navigate to your Swagger UI in your browser, make sure you have selected the *api-service* and then click Authorize. Now paste in your token and login!

Now we are ready to send a start-evaluation event just as we did before through the CLI. The only difference is that the API expects a start & time timestamp and doesnt provide the convenient option of a timeframe. That's why you have to make sure to put in timestamps where you know you have data in your Dynatrace environment. Here is my prepared POST body including the JSON object for start-evaluation:

```
{
  "type": "sh.keptn.event.start-evaluation",
  "source": "https://github.com/keptn/keptn",
  "data": {
    "start": "2020-05-27T07:00:00.000Z",
    "end": "2020-05-27T07:05:00.000Z",
    "project": "qgproject",
    "stage": "qualitystage",
    "service": "evalservice",
    "teststrategy": "manual"
  }
}
```

Please take attention that the above CloudEvent contains the property `"teststrategy": "manual"`. This is required to tell Keptn that we didn't use Keptn to execute any tests prior to the evaluation but that we just want to do a manual evaluation.  

Negative
: Please remember that the start and end time has to be changed to reflect the time frame you want to evaluate!

In the Swagger UI scroll to the POST /event API call. Click on Try, then post the JSON body into the edit field like shown here:
![](./assets/dynatrace_qualitygates/swagger_postevent_startevaluation.png)

The great thing about Swagger UI is that it will not only execute the request and give you the response. It will also give you the corresponding CURL command so you can easily integrate this API call into your automation scripts. The following shows the output including the response which includes the keptnContext ID of our triggered evaluation:
![](./assets/dynatrace_qualitygates/swagger_postevent_startevaluation_response.png)

For your reference - here is the CURL command for easy copy/paste in case you want to execute this from your command line:
```
curl -X POST "$KEPTN_ENDPOINT/v1/event" -H "accept: application/json" -H "x-token: $KEPTN_API_TOKEN" -H "Content-Type: application/json" -d "{ \"type\": \"sh.keptn.event.start-evaluation\", \"source\": \"https://github.com/keptn/keptn\", \"data\": { \"start\": \"2020-05-27T07:00:00.000Z\", \"end\": \"2020-05-27T07:05:00.000Z\", \"project\": \"qgproject\", \"stage\": \"qualitystage\", \"service\": \"evalservice\", \"teststrategy\": \"manual\" }}"
```

5. Query for evaluation-done

Remember from when we ran through this exercise with the Keptn CLI? The evaluation may take up to a minute. In order to check whether the evaluation is done and what the result was we can now call the GET /events API endpoint and query the existence of an sh.keptn.events.evaluation-done event for the keptnContext we retrieved earlier:

You can execute this through the Swagger UI or - as it is rather simple and straight forward - using the following CURL:

```
curl -X GET "$KEPTN_ENDPOINT/v1/event?keptnContext=KEPTN_CONTEXT_ID&type=sh.keptn.events.evaluation-done" -k -H "accept: application/json" -H "x-token: $KEPTN_API_TOKEN"
```

The result comes in the form of the `evaluation-done` event, which is specified [here](https://github.com/keptn/spec/blob/0.1.3/cloudevents.md#evaluation-done).

Here the screenshot of the response in Swagger UI:
![](./assets/dynatrace_qualitygates/swagger_getevent_response.png)

6. Evaluate in Bridge & Dynatrace

Just as we did before you can also validate the data in the Keptn's Bridge as well as in Dynatrace!
