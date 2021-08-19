summary: Automated Upscaling with Dynatrace
id: keptn-upscaling-dynatrace-07
categories: dynatrace,upscaling,gke,aks,eks,minikube,pks,openshift,automated-operations
tags: keptn07x
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials


# Automated Upscaling with Dynatrace

## Welcome 
Duration: 2:00

In this tutorial, you will learn how to use the capabilities of Keptn to provide self-healing for an application without modifying code. The following tutorial will scale up the pods of an application if the application undergoes heavy CPU saturation. 

### What you'll learn
- How to create a sample project
- How to onboard a first microservice
- How to deploy your first microservice with blue/green deployments
- How to define a remediation file 
- How Keptn can automatically execute remediation actions based on issues detected by Dynatrace

You'll find a time estimate until the end of this tutorial in the right top corner of your screen - this should give you guidance how much time is needed for each step.

{{ snippets/07/install/cluster.md }}

{{ snippets/07/install/istio.md }}

{{ snippets/07/install/download-keptnCLI.md }}

{{ snippets/07/install/install-full.md }}

{{ snippets/07/install/configureIstio.md }}

{{ snippets/07/install/authCLI-istio.md }}

{{ snippets/07/monitoring/setupDynatrace.md }}


{{ snippets/07/manage/createProject.md }}

{{ snippets/07/manage/onboardService.md }}

{{ snippets/07/monitoring/install-sli-provider-dynatrace.md }}



## Add remediation instructions to Keptn
Duration: 4:00

To inform Keptn about any issues in a production environment, monitoring has to be set up correctly. The Keptn CLI helps with the automated setup and configuration of Dynatrace as the monitoring solution running in the Kubernetes cluster. 

To add these files to Keptn and to automatically configure Dynatrace, execute the following commands:

1. Make sure you are in the correct folder of your examples directory:
    ```
    cd examples/onboarding-carts
    ```

1. Configure remediation actions for up-scaling based on Dynatrace alerts:

    ```
    keptn add-resource --project=sockshop --stage=production --service=carts --resource=remediation.yaml --resourceUri=remediation.yaml
    ```

    This is how the file looks that we are going to add here:

    ```
    apiVersion: spec.keptn.sh/0.1.4
    kind: Remediation
    metadata:
      name: service-remediation
    spec:
      remediations:
        - problemType: Response time degradation
          actionsOnOpen:
          - action: scaling
            name: scaling
            description: Scale up
            value: 1
        - problemType: response_time_p90
          actionsOnOpen:
            - action: scaling
              name: scaling
              description: Scale up
              value: 1
    ```

1. Add an SLO file to the production stage for Keptn to do an evaluation if the remediation action was successful.
    ```
    keptn add-resource --project=sockshop --stage=production --service=carts --resource=slo-self-healing.yaml --resourceUri=slo.yaml
    ```

## Configure your Dynatrace tenant
Duration: 5:00

Configure Dynatrace problem detection with a fixed threshold: For the sake of this demo, we will configure Dynatrace to detect problems based on fixed thresholds rather than automatically. 

Log in to your Dynatrace tenant and go to **Settings > Anomaly Detection > Services**.

Within this menu, select the option **Detect response time degradations using fixed thresholds**, set the limit to **1000ms**, and select **Medium** for the sensitivity as shown below.

![anomaly detection](./assets/dt-upscaling-anomaly-detection.png)

Positive
: You can also configure those fixed thresholds per service instead of globally.


## Run the experiment
Duration: 7:00


To simulate user traffic that is causing an unhealthy behavior in the carts service, please execute the following script. This will add special items into the shopping cart that cause some extensive calculation.

1. Move to the correct folder for the load generation scripts:
  ```
  cd ../load-generation/cartsloadgen/deploy
  ```

1. Start the load generation script: 

  ```
  kubectl apply -f cartsloadgen-faulty.yaml
  ```

1. **Optional:** Verify the load in Dynatrace

    In your Dynatrace Tenant, inspect the *Response Time* chart of the correlating service entity of the carts microservice. *Hint:* You can find the service 
    in Dynatrace easier by selecting the management zone **Keptn: sockshop production**:

    ![services](./assets/dt-upscaling-services.png)
        

    ![response time](./assets/dt-upscaling-response-time.png)

As you can see in the time series chart, the load generation script causes a significant increase in the response time.

## Watch self-healing in action
Duration: 10:00

After approximately 10-15 minutes, Dynatrace will send out a problem notification because of the response time degradation. 

After receiving the problem notification, the *dynatrace-service* will translate it into a Keptn CloudEvent. This event will eventually be received by the *remediation-service* that will look for a remediation action specified for this type of problem and, if found, execute it.

In this tutorial, the number of pods will be increased to remediate the issue of the response time increase. 

1. Check the executed remediation actions by executing:

    ```
    kubectl get deployments -n sockshop-production
    ```

    You can see that the `carts-primary` deployment is now served by two pods:

    ```
    NAME             DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    carts-db         1         1         1            1           37m
    carts-primary    2         2         2            2           32m
    ```

1. Besides, you should see an additional pod running when you execute:

    ```
    kubectl get pods -n sockshop-production
    ```

    ```
    NAME                              READY   STATUS    RESTARTS   AGE
    carts-db-57cd95557b-r6cg8         1/1     Running   0          38m
    carts-primary-7c96d87df9-75pg7    2/2     Running   0          33m
    carts-primary-7c96d87df9-78fh2    2/2     Running   0          5m
    ```

1. To get an overview of the actions that got triggered by the response time violation, you can use the Keptn's Bridge.

    In this example, the bridge shows that the remediation service triggered an update of the configuration of the carts service by increasing the number of replicas to 2. When the additional replica was available, the wait-service waited for 10 minutes for the remediation action to take effect. Afterwards, an evaluation by the lighthouse-service was triggered to check if the remediation action resolved the problem. In this case, increasing the number of replicas achieved the desired effect since the evaluation of the service level objectives has been successful.
    
    ![bridge](./assets/dt-bridge-remediation-upscale.png)
    
    ![bridge](./assets/dt-bridge-remediation-evaluation-done.png)

1. Furthermore, you can see how the response time of the service decreased by viewing the time series chart in Dynatrace:

    As previously, go to the response time chart of the *ItemsController* service. Here you will see that the additional instance has helped to bring down the response time.
    Eventually, the problem that has been detected earlier will be closed automatically.

    ![problem closed](./assets/dt-upscaling-problem-closed.png)
    
## Finish

You have successfully walked through the example to scale up your application based on high CPU consumption detected by Dynatrace.

### What we've covered

- Setting up auto-remediation with a `remediation.yaml` file
  ```
    apiVersion: spec.keptn.sh/0.1.4
    kind: Remediation
    metadata:
      name: service-remediation
    spec:
      remediations:
        - problemType: Response time degradation
          actionsOnOpen:
          - action: scaling
            name: scaling
            description: Scale up
            value: 1
        - problemType: response_time_p90
          actionsOnOpen:
            - action: scaling
              name: scaling
              description: Scale up
              value: 1
  ```

- Execute an experiment to see self-healing in action
  ![response time](./assets/dt-upscaling-response-time.png)

- Verified that Keptn executed the remediation action
  ![bridge](./assets/dt-bridge-remediation-upscale.png)

Positive
: Congratulations for a successful auto-remediation with Keptn!

{{ snippets/07/integrations/gettingStarted.md }}

{{ snippets/07/community/feedback.md }}
