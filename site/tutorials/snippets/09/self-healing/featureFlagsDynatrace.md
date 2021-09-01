## Self-healing with feature flags
Duration: 2:00

Next, you will learn how to use the capabilities of Keptn to provide self-healing for an application with feature flags based on the [Unleash feature toggle framework](https://unleash.github.io/). 


Positive
: For the sake of this tutorial, we will create an Unleash Keptn project. The carts microservice is already pre-configured for this.

To quickly get an Unleash server up and running with Keptn, follow these instructions:

1. Make sure you are in the correct folder of your examples directory:

    <!-- bash cd ../.. -->

    <!-- command -->
    ```
    cd examples/unleash-server
    ```


1. Create a new project using the `keptn create project` command:

    <!-- command -->
    ```
    keptn create project unleash --shipyard=./shipyard.yaml
    ```

1. Create a unleash and unleash-db service using the `keptn create service` and `keptn add-resource` commands:

    <!-- command -->
    ```
    keptn create service unleash-db --project=unleash
    keptn add-resource --project=unleash --service=unleash-db --all-stages --resource=./unleash-db --resourceUri=helm/unleash-db.tgz

    keptn create service unleash --project=unleash
    keptn add-resource --project=unleash --service=unleash --all-stages --./resource=unleash --resourceUri=helm/unleash.tgz
    ```

1. Send new artifacts for unleash and unleash-db using the `keptn trigger delivery` command:

    <!-- command -->
    ```
    keptn trigger delivery --project=unleash --service=unleash-db --image=postgres:10.4 
    keptn trigger delivery --project=unleash --service=unleash --image=docker.io/keptnexamples/unleash:1.0.0 
    ```
    
    <!-- bash 
    verify_test_step $? "trigger delivery for unleash failed"
    wait_for_deployment_with_image_in_namespace "unleash-db" "unleash-dev" "postgres:10.4"
    wait_for_deployment_with_image_in_namespace "unleash" "unleash-dev" "docker.io/keptnexamples/unleash:1.0.0"
    -->

1. Get the URL (`unleash.unleash-dev.KEPTN_DOMAIN`):

    <!-- command -->
    ```
    echo http://unleash.unleash-dev.$(kubectl -n keptn get ingress api-keptn-ingress -ojsonpath='{.spec.rules[0].host}')
    ```

1. Open the URL in your browser and log in using the following credentials:
   * Username: keptn
   * Password: keptn

You should be able to login using the credentials *keptn/keptn*.

## Configure the Unleash server
Duration: 4:00

In this tutorial, we are going to introduce feature toggles for two scenarios:

1. Feature flag for a very simple caching mechanism that can speed up the delivery of the website since it skips the calls to the database but instead replies with static content.

1. Feature flag for a promotional campaign that can be enabled whenever you want to run a promotional campaign on top of your shopping cart.

To set up both feature flags, please use the following scripts to automatically generate the feature flags that we need in this tutorial.



<!-- command -->
``` 
export UNLEASH_TOKEN=$(echo -n keptn:keptn | base64)
export UNLEASH_BASE_URL=$(echo http://unleash.unleash-dev.$(kubectl -n keptn get ingress api-keptn-ingress -ojsonpath='{.spec.rules[0].host}'))

curl --request POST \
  --url ${UNLEASH_BASE_URL}/api/admin/features/ \
  --header "authorization: Basic ${UNLEASH_TOKEN}" \
  --header 'content-type: application/json' \
  --data '{
  "name": "EnableItemCache",
  "description": "carts",
  "enabled": false,
	"strategies": [
    {
      "name": "default",
      "parameters": {}
    }
  ]
}'

curl --request POST \
  --url ${UNLEASH_BASE_URL}/api/admin/features/ \
  --header "authorization: Basic ${UNLEASH_TOKEN}" \
  --header 'content-type: application/json' \
  --data '{
  "name": "EnablePromotion",
  "description": "carts",
  "enabled": false,
	"strategies": [
    {
      "name": "default",
      "parameters": {}
    }
  ]
}'
```

### Optionally verify the generated feature flags

If you want to verify the feature flags that have been created, please login to your Unleash server - or if you are already logged in - refresh the browser.

![unleash](./assets/unleash-ff.png)


## Configure Keptn
Duration: 5:00

Now, everything is set up in the Unleash server. For Keptn to be able to connect to the Unleash server, we have to add a secret with the Unleash API URL as well as the Unleash tokens.

1. In order for Keptn to be able to use the Unleash API, we need to add the credentials as a secret to our Keptn namespace. In this tutorial, we do not have to change the values for UNLEASH_SERVER, UNLEASH_USER, and UNLEASH_TOKEN, but in your own custom scenario this might be needed to change it to your actual Unleash URL, user and token. 
As said, in this tutorial we can use the following command as it is:

    <!-- command -->
    ```
    kubectl -n keptn create secret generic unleash --from-literal="UNLEASH_SERVER_URL=http://unleash.unleash-dev/api" --from-literal="UNLEASH_USER=keptn" --from-literal="UNLEASH_TOKEN=keptn"
    ```

1. Install the Unleash action provider which is responsible for acting upon an alert, thus it is the part that will actually resolve issues by changing the stage of the feature flags.
    
    <!-- command -->
    ```
    kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/unleash-service/release-0.3.2/deploy/service.yaml -n keptn
    ```

1. Switch to the carts example (`cd examples/onboarding-carts`) and add the following remediation instructions

    ```
    apiVersion: spec.keptn.sh/0.1.4
    kind: Remediation
    metadata:
      name: carts-remediation
    spec:
      remediations:
        - problemType: Response time degradation
          actionsOnOpen:
            - action: toggle-feature
              name: Toogle feature flag
              description: Toogle feature flag EnableItemCache to ON
              value:
                EnableItemCache: "on"
        - problemType: Failure rate increase
          actionsOnOpen:
            - action: toggle-feature
              name: Toogle feature flag
              description: Toogle feature flag EnablePromotion to OFF
              value:
                EnablePromotion: "off"
    ```

    using the following command. Please make sure you are in the correct folder `examples/onboarding-carts`.
    
    <!-- bash cd ../onboarding-carts -->
    
    <!-- command -->
    ```
    keptn add-resource --project=sockshop --service=carts --stage=production --resource=remediation_feature_toggle.yaml --resourceUri=remediation.yaml
    ```

    **Note:** The file describes remediation actions (e.g., `featuretoggle`) in response to problems/alerts (e.g., `Response time degradation`) that are sent to Keptn.

1. We are also going to add an SLO file so that Keptn can evaluate if the remediation action was successful.
    <!-- command -->
    ```
    keptn add-resource --project=sockshop --stage=production --service=carts --resource=slo-self-healing-dynatrace.yaml --resourceUri=slo.yaml
    ```

1. Start the load generation script for this use case:
    <!-- command -->
    ```
    kubectl apply -f ../load-generation/cartsloadgen/deploy/cartsloadgen-prod.yaml
    ```

Positive
: Please note that in a production environment you would have to set it up differently. We have deployed Unleash only in a single-stage environment while we have our application that we manage with Unleash in a multi-stage environment. This was done for the sake of resource-saving.
That means, in our example, the Unleash server will control the behavior for all three stages (this is what you would probably not want in a production environment). Therefore, we started the load-generation only for the production stage to not impact the other stages.

Now that everything is set up and we hit it with some load, next we are going to toggle the feature flags.

## Run the experiment
Duration: 5:00

1. In this tutorial, we are going to turn on the promotional campaign, which purpose is to add promotional gifts to about 30&nbsp;% of the user interactions that put items in their shopping cart. 

1. Click on the toggle next to **EnablePromotion** to enable this feature flag.

    <!-- bash 
    curl --request POST \
      --url ${UNLEASH_BASE_URL}/api/admin/features/EnablePromotion/toggle/on \
      --header "authorization: Basic ${UNLEASH_TOKEN}"
    -->
    
    ![enable-toggle](./assets/unleash-promotion-toggle-on.png)

1. By enabling this feature flag, a not implemented function is called resulting in a *NotImplementedFunction* error in the source code and a failed response. After a couple of minutes, the monitoring tool will detect an increase in the failure rate and will send out a problem notification to Keptn.

1. Keptn will receive the problem notification/alert and look for a remediation action that matches this problem. Since we have added the `remediation.yaml` before, Keptn will find a remediation action and will trigger the corresponding action by reaching out to the action provider that will disable the feature flag.

1. Finally, take a look into the Keptn's Bridge to see that an open problem has been resolved. You might notice that also the other stages like _dev_, and _staging_ received the error. The reason is that they all receive the same feature flag configuration and all receive traffic from the load generator. However, for _dev_ and _staging_ there is no `remediation.yaml` added and thus, no remediation will be performed if problems in this stages are detected. If you want to change this behaviour, go ahead and also add the `remediation.yaml` file to the other stages by executing another `keptn add-resource` command. For this tutorial, we are fine by only having self-healing for our production stage!
    
    ![bridge unleash](./assets/bridge-unleash-remediation-keptn083.png)

1. 10 minutes after Keptn disables the feature flag, Keptn will also trigger another evaluation to make sure the trigger remediation action did actually resolve the problem. In case the problem is not resolved and the remediation file would hold more remediation actions, Keptn would go ahead and trigger them. For our tutorial Keptn has resolved the issue already, so no need for a second try!

<!-- bash 
echo "Waiting for Keptn to disable the feature flag"
wait_for_event_with_field_output "sh.keptn.events.problem" ".data.ProblemDetails.status" "CLOSED" "sockshop"
-->
