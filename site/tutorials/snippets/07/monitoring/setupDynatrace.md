
## Setup Dynatrace
Duration: 7:00

For enabling the Keptn Quality Gates and for production monitoring, we are going to use Dynatrace as the data provider. Therefore, we are going to setup Dynatrace in our Kubernetes cluster to have our sample application monitored and we can use the monitoring data for both the basis for evaluating quality gates as well as a trigger to start self-healing.

Positive
: You have to bring your own Dynatrace tenant

If you don't have a Dynatrace tenant yet, sign up for a [free trial](https://www.dynatrace.com/trial/) or a [developer account](https://www.dynatrace.com/developer/).

## Gather Dynatrace tokens
Duration: 6:00

1. Create a Dynatrace API Token

    Log in to your Dynatrace tenant and go to **Settings > Integration > Dynatrace API**. Then, create a new API token with the following permissions:

    - Access problem and event feed, metrics and topology
    - Access logs
    - Read configuration
    - Write configuration
    - Capture request data

    Take a look at this screenshot to double check the right token permissions for you.

    ![Dynatrace API Token](./assets/dt_api_token.png)

1. Create a Dynatrace PaaS Token

    In your Dynatrace tenant, go to **Settings > Integration > Platform as a Service**, and create a new PaaS Token.

1. Store your credentials in a Kubernetes secret by executing the following command. The `DT_TENANT` has to be set according to the appropriate pattern:
  - Dynatrace SaaS tenant (this format is most likely for you): `{your-environment-id}.live.dynatrace.com`
  - Dynatrace-managed tenant: `{your-domain}/e/{your-environment-id}`

    If running on a Unix/Linux based system, you can use variables for ease of use. Naturally, it is also fine to just replace the values in the `kubectl` command itself.

    <!-- var DT_TENANT -->
    <!-- var DT_API_TOKEN -->
    <!-- var DT_PAAS_TOKEN -->

    ```
    export DT_TENANT=yourtenant.live.dynatrace.com
    export DT_API_TOKEN=yourAPItoken
    export DT_PAAS_TOKEN=yourPAAStoken
    ```

    Negative
    : Please make sure your DT_TENANT does _not contain_ any trailing slashes nor a https:// in the beginning.

    If you used the variables, the next command can be copied and pasted without modifications. If you have not set the variables, please make sure to set the right values in the next command.
    
    <!-- command -->
    ```
    kubectl -n keptn create secret generic dynatrace --from-literal="DT_TENANT=$DT_TENANT" --from-literal="DT_API_TOKEN=$DT_API_TOKEN"  --from-literal="DT_PAAS_TOKEN=$DT_PAAS_TOKEN" --from-literal="KEPTN_API_URL=http://$(kubectl -n keptn get ingress api-keptn-ingress -ojsonpath='{.spec.rules[0].host}')/api" --from-literal="KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath='{.data.keptn-api-token}' | base64 --decode)" --from-literal="KEPTN_BRIDGE_URL=http://$(kubectl -n keptn get ingress api-keptn-ingress -ojsonpath='{.spec.rules[0].host}')/bridge" 
    ```

## Deploy Dynatrace OneAgent Operator

To make the tutorial experience as smooth as possible, we are providing an automation script to setup the Dynatrace OneAgent operator in your Kubernetes cluster. For details on the installation, we refer to the [official Dynatrace documentation](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/deploy-oneagent-k8/). You can download and run the script using the following instructions.

1. Downloading the automation file.

    <!-- command -->
    ```
    curl -o deploy-dynatrace-oneagent.sh https://raw.githubusercontent.com/keptn/examples/release-0.7.0/dynatrace-oneagent/deploy-dynatrace-oneagent.sh
    ```

1. Making the file executable using the `chmod` command.

    <!-- command -->
    ```
    chmod +x deploy-dynatrace-oneagent.sh
    ```

1. Executing the script to automatically deploys the Dynatrace OneAgent Operator.

    <!-- command -->
    ```
    ./deploy-dynatrace-oneagent.sh
    ```

1. Optional: Verify if all pods in the Dynatrace namespace are running. It might take up to 1-2 minutes for all pods to be up and running.

    <!-- debug -->
    ```
    kubectl get pods -n dynatrace
    ```

    ```
    dynatrace-oneagent-operator-696fd89b76-n9d9n   1/1     Running   0          6m26s
    dynatrace-oneagent-webhook-78b6d99c85-h9759    2/2     Running   0          6m25s
    oneagent-g9m42                                 1/1     Running   0          69s
    ```


## Install Dynatrace integration
Duration: 5:00

1. The Dynatrace integration into Keptn is handled by the *dynatrace-service*. To install the *dynatrace-service*, execute:

    <!-- command -->
    ```
    kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-service/0.8.0/deploy/service.yaml
    ```

1. When the service is deployed, use the following command to install Dynatrace on your cluster. If Dynatrace is already deployed, the current deployment of Dynatrace will not be modified.

    <!-- command -->
    ```
    keptn configure monitoring dynatrace
    ```

    Output should be similar to this:
    ```
    ID of Keptn context: 79f19c36-b718-4bb6-88d5-cb79f163289b
    Configuring Dynatrace monitoring
    Dynatrace OneAgent Operator is installed on cluster
    Setting up auto-tagging rules in Dynatrace Tenant
    Tagging rule keptn_service already exists
    Tagging rule keptn_stage already exists
    Tagging rule keptn_project already exists
    Tagging rule keptn_deployment already exists
    Setting up problem notifications in Dynatrace Tenant
    Checking Keptn alerting profile availability
    Keptn alerting profile available
    Dynatrace Monitoring setup done
    ```

**Verify Dynatrace configuration**

Since Keptn has configured your Dynatrace tenant, let us take a look what has be done for you:


- *Tagging rules:* When you navigate to **Settings > Tags > Automatically applied tags** in your Dynatrace tenant, you will find following tagging rules:
    - keptn_deployment
    - keptn_project
    - keptn_service
    - keptn_stage
  
    This means that Dynatrace will automatically apply tags to your onboarded services.

- *Problem notification:* A problem notification has been set up to inform Keptn of any problems with your services to allow auto-remediation. You can check the problem notification by navigating to **Settings > Integration > Problem notifications** and you will find a **keptn remediation** problem notification.

- *Alerting profile:* An alerting profile with all problems set to *0 minutes* (immediate) is created. You can review this profile by navigating to **Settings > Alerting > Alerting profiles**.

- *Dashboard and Mangement zone:* When creating a new Keptn project or executing the [keptn configure monitoring](https://keptn.sh/docs/0.6.0/reference/cli/commands/keptn_configure_monitoring/) command for a particular project (see Note 1), a dashboard and management zone will be generated reflecting the environment as specified in the shipyard file.


Negative
: If the nodes in your cluster run on *Container-Optimized OS (cos)* (default for GKE), the Dynatrace OneAgent might not work properly, the next steps are necessary. 

Follow the next steps only if your Dynatrace OneAgent does not work properly.

<!-- bash kubectl get pods -n dynatrace -->

1. To check if the OneAgent does not work properly, the output of `kubectl get pods -n dynatrace` might look as follows:

  ```
  NAME                                           READY   STATUS             RESTARTS   AGE
  dynatrace-oneagent-operator-7f477bf78d-dgwb6   1/1     Running            0          8m21s
  oneagent-b22m4                                 0/1     Error              6          8m15s
  oneagent-k7jn6                                 0/1     CrashLoopBackOff   6          8m15s
  ```

1. This means that after the initial setup you need to edit the OneAgent custom resource in the Dynatrace namespace and add the following entry to the env section:

        env:
        - name: ONEAGENT_ENABLE_VOLUME_STORAGE
          value: "true"

1. To edit the OneAgent custom resource: 

    ```
    kubectl edit oneagent -n dynatrace
    ```


At the end of your installation, please verify that all Dynatrace resources are in a Ready and Running status by executing `kubectl get pods -n dynatrace`:

```
NAME                                           READY   STATUS       RESTARTS   AGE
dynatrace-oneagent-operator-7f477bf78d-dgwb6   1/1     Running      0          8m21s
oneagent-b22m4                                 1/1     Running      0          8m21s
oneagent-k7jn6                                 1/1     Running      0          8m21s
```
