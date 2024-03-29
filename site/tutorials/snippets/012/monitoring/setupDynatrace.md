
## Set up Dynatrace
Duration: 7:00

For enabling the Keptn Quality Gates and for production monitoring, we are going to use Dynatrace as the data provider. Therefore, we are going to setup Dynatrace in our Kubernetes cluster to have our sample application monitored and we can use the monitoring data for both the basis for evaluating quality gates as well as a trigger to start self-healing.

Positive
: You have to bring your own Dynatrace tenant

If you don't have a Dynatrace tenant yet, sign up for a [free trial](https://www.dynatrace.com/trial?utm_campaign=keptn) or a [developer account](https://www.dynatrace.com/developer/).

## Deploy Dynatrace OneAgent Operator

To monitor a Kubernetes environment using Dynatrace, please setup dynatrace-operator as described below, or visit the [official Dynatrace documentation](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/deploy-oneagent-k8/).

For setting up dynatrace-operator, perform the following steps:

1. Log into your Dynatrace environment
1. Open Dynatrace Hub (on the left hand side, scroll down to **Manage** and click on **Hub**)
1. Within Dynatrace Hub, search for Kubernetes
   ![Dynatrace Hub](./assets/dt-hub-kubernetes.png)
1. Click on Kubernetes, and select **Monitor Kubernetes** at the bottom of the screen
1. In the following screen, select the Platform and click on **Create tokens** to generate PaaS and API tokens.
1. Select options appropriate for your cluster:
    - By default, most Kubernetes clusters will only offer a self-signed certificate. In such cases, please select *Skip SSL Security Check* when deploying the Dynatrace OneAgent Operator.
    - When deploying the Dynatrace OneAgent Operator to a cluster running on a *Container-Optimized OS (cos)*, which includes GKE, Anthos, CaaS and PKS environments, please select the *Enable volume storage* option.
   ![Dynatrace Kubernetes Monitoring](./assets/dt-kubernetes-monitor.png)
1. Copy the generated code and run it in a terminal/bash
1. Optional: Verify if all pods in the `dynatrace` namespace are running. It might take up to 1-2 minutes for all pods to be up and running.

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

## Create Dynatrace credentials secret
Duration: 6:00

Next, create a Kubernetes secret containing the credentials for accessing the API of the Dynatrace tenant. The secret must have two components: a Dynatrace API token (`DT_API_TOKEN`) and a Dynatrace tenant URL (`DT_TENANT`).

1. To create a Dynatrace API token, log in to your Dynatrace tenant and go to **Manage > Access tokens** and click **Generate token**. Then, select the following scopes:

    - Read entities (`entities.read`)
    - Read metrics (`metrics.read`)
    - Read problems (`problems.read`)
    - Read security problems (`securityProblems.read`)
    - Read SLO (`slo.read`)
    - Access problem and event feed, metrics, and topology (`DataExport`)
    - User sessions (`DTAQLAccess`)
    - Read configuration (`ReadConfig`)
    - Write configuration (`WriteConfig`)

    Take a look at following screenshot to double check the selected scopes.

    ![Dynatrace API token scopes](./assets/dt_api_token_scopes.png)

    Name the token and then click **Generate token**. Copy and store the generated token securely.

1. Determine the Dynatrace tenant URL. The value of `DT_TENANT` has to be set according to the appropriate pattern:
    - Dynatrace SaaS tenant (this format is most likely for you): `{your-environment-id}.live.dynatrace.com`
    - Dynatrace-managed tenant: `{your-domain}/e/{your-environment-id}`


1. Store your credentials in a Keptn-managed secret by executing the following command. If running on a Unix/Linux based system, you can use variables for ease of use. Naturally, it is also fine to just replace the values in the `keptn` command itself.

    <!-- var DT_TENANT -->
    <!-- var DT_API_TOKEN -->

    ```
    DT_TENANT=yourtenant.live.dynatrace.com
    DT_API_TOKEN=yourAPItoken
    ```

    If you used the variables, the next command can be copied and pasted without modifications. If you have not set the variables, please make sure to set the right values in the next command.
    
    <!-- command -->
    ```
    keptn create secret dynatrace --scope=dynatrace-service --from-literal="DT_TENANT=$DT_TENANT" --from-literal="DT_API_TOKEN=$DT_API_TOKEN" 
    ```

## Install Dynatrace integration
Duration: 5:00

1. The *dynatrace-service* integrates Dynatrace into Keptn. The latest version may be installed using the helm chart available in the Releases section of the GitHub project. Please use the same namespace for the dynatrace-service as you are using for Keptn, e.g. `keptn`:

    <!-- command bash -->
    ```
    helm upgrade --install dynatrace-service -n keptn https://github.com/keptn-contrib/dynatrace-service/releases/download/0.20.0/dynatrace-service-0.20.0.tgz --set dynatraceService.config.keptnApiUrl=$KEPTN_ENDPOINT --set dynatraceService.config.keptnBridgeUrl=$KEPTN_BRIDGE_URL --set dynatraceService.config.generateTaggingRules=true --set dynatraceService.config.generateProblemNotifications=true --set dynatraceService.config.generateManagementZones=true --set dynatraceService.config.generateDashboards=true --set dynatraceService.config.generateMetricEvents=true 

    ```