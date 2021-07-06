
## Setup Dynatrace
Duration: 7:00

For enabling the Keptn Quality Gates and for production monitoring, we are going to use Dynatrace as the data provider. Therefore, we are going to setup Dynatrace in our Kubernetes cluster to have our sample application monitored and we can use the monitoring data for both the basis for evaluating quality gates as well as a trigger to start self-healing.

Positive
: You have to bring your own Dynatrace tenant

If you don't have a Dynatrace tenant yet, sign up for a [free trial](https://www.dynatrace.com/trial/) or a [developer account](https://www.dynatrace.com/developer/).

## Create Dynatrace tokens
Duration: 6:00

1. Create a Dynatrace API Token

    Log in to your Dynatrace tenant and go to **Settings > Integration > Dynatrace API**. Then, create a new API token with the following permissions:

    - Access problem and event feed, metrics, and topology
    - Read log content
    - Read configuration
    - Write configuration
    - Capture request data
    - Read metrics
    - Ingest metrics
    - Read entities

    Take a look at this screenshot to double check the right token permissions for you.

    ![Dynatrace API V1 Token](./assets/dt_apiv1_token.png)
    ![Dynatrace API V2 Token](./assets/dt_apiv2_token.png)

1. Create a Dynatrace PaaS Token

    In your Dynatrace tenant, go to **Settings > Integration > Platform as a Service**, and create a new PaaS Token.

## Deploy Dynatrace OneAgent Operator

To monitor a Kubernetes environment using Dynatrace, please setup dynatrace-operator as described below, or visit the [official Dynatrace documentation](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/deploy-oneagent-k8/).

For setting up dynatrace-operator, perform the following steps:

1. Log into your Dynatrace environment
1. Open Dynatrace Hub (on the left hand side, scroll down to **Manage** and click on **Deploy Dynatrace**)
1. Within Dynatrace Hub, search for Kubernetes
   ![Dynatrace Hub](./assets/dt-hub-kubernetes.png)
1. Click on Kubernetes, and select **Monitor Kubernetes** at the bottom of the screen
1. In the following screen, select the Platform, a PaaS and API Token, and the OneAgent installation options.

   **Note**: Please make sure to tick *Enable volume storage* if you are on GKE, Anthos, CaaS and PKS.

   ![Dynatrace Kubernetes Monitoring](./assets/dt-kubernetes-monitor.png)

1. Copy the generated code and run it in a terminal/bash
1. Optional: Verify if all pods in the Dynatrace namespace are running. It might take up to 1-2 minutes for all pods to be up and running.

    <!-- debug -->
    ```
    kubectl get pods -n dynatrace
    ```

    ```
    NAME                                          READY   STATUS    RESTARTS   AGE
    dynakube-kubemon-0                            1/1     Running   0          11h
    dynatrace-oneagent-operator-cc9856cfd-hrv4x   1/1     Running   0          2d11h
    dynatrace-oneagent-webhook-5d67c9bb76-pz2gh   2/2     Running   0          2d11h
    dynatrace-operator-fb56f7f59-pf5sg            1/1     Running   0          2d11h
    oneagent-gc2lc                                1/1     Running   0          35h
    oneagent-w7msm                                1/1     Running   0          35h
    ```
   
    Note: If you are on newer versions of OneAgent / Dynatrace Operator, pods might look as follows:
    ```
    NAME                                          READY   STATUS    RESTARTS   AGE
    dynakube-classic-d2ckw                        1/1     Running   0          1d13h
    dynakube-kubemon-0                            1/1     Running   0          15h
    dynakube-routing-0                            1/1     Running   0          23h
    dynatrace-operator-fb56f7f59-pf5sg            1/1     Running   0          1d13h
    ```

    **Note**: In case any pods are crashing with `CrashLoopBackOff` or `Error`, please double check that you ticked *Enable volume storage*. Alternatively, please take a look at [the official OneAgent troubleshooting guide](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/maintenance/troubleshoot-deployment-and-connectivity/#anchor_deploy).
   
1. Optional: Verify in your Dynatrace Environment under the section *Kubernetes* that your cluster is monitored.

## Install Dynatrace integration
Duration: 5:00

1. The Dynatrace integration into Keptn is handled by the *dynatrace-service*. To install the *dynatrace-service*, execute:

    <!-- command -->
    ```
    helm upgrade \
    --install dynatrace-service \
    -n keptn \
    --set dynatraceService.config.keptnApiUrl=$KEPTN_ENDPOINT/api \
    --set dynatraceService.config.keptnBridgeUrl=$KEPTN_ENDPOINT/bridge \
    https://github.com/keptn-contrib/dynatrace-service/releases/download/0.15.0/dynatrace-service-0.15.0.tgz
    ```

1. Once the *dynatrace-service* has been installed, create the `dynatrace` secret in the Keptn Bridge by navigating to **Projects > *Dynatrace* > Uniform > Secrets** and clicking **Add Secret**. Enter `dynatrace` as the name and add two key-value pairs with the keys `DT_TENANT` and `DT_API_TOKEN` as well as their respective values.

  - The `DT_TENANT` has to be set according to the appropriate pattern:
    - Dynatrace SaaS tenant (this format is most likely for you): `{your-environment-id}.live.dynatrace.com`
    - Dynatrace-managed tenant: `{your-domain}/e/{your-environment-id}`

  - `DT_API_TOKEN` should be set to the Dynatrace API token created earlier.

    ![Creating the Dynatrace secret](./assets/dt_add_secret.png)


1. When the service is deployed, use the following command to install Dynatrace on your cluster. If Dynatrace is already deployed, the current deployment of Dynatrace will not be modified.

    <!-- command -->
    ```
    keptn configure monitoring dynatrace
    ```

    The output of the command will tell you what has been set up in your Dynatrace environment:
    ```
    ID of Keptn context: 79f19c36-b718-4bb6-88d5-cb79f163289b
    Dynatrace monitoring setup done.
    The following entities have been configured:
    
    ...
    ---Problem Notification:--- 
      - Successfully set up Keptn Alerting Profile and Problem Notifications
    ...

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
