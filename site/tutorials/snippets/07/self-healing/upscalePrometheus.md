

## Enable Self-Healing 
Duration: 2:00

Next, you will learn how to use the capabilities of Keptn to provide self-healing for an application without modifying code. In the next part, we configure Keptn to scale up the pods of an application if the application undergoes heavy CPU saturation. 

Negative
: First, make sure you are in the correct folder `examples/onboarding-carts` otherwise the next commands will fail.

Add the prepared SLO file for self-healing to the production stage using the Keptn CLIs add-resource command:

<!-- command -->
```
keptn add-resource --project=sockshop --stage=production --service=carts --resource=slo-self-healing.yaml --resourceUri=slo.yaml
```

Note: The SLO file contains an objective for response_time_p90.


Configure Prometheus with the Keptn CLI (this configures the [Alert Manager](https://prometheus.io/docs/alerting/configuration/) based on the slo.yaml file):

<!-- command -->
```
keptn configure monitoring prometheus --project=sockshop --service=carts
```

Configure remediation actions for up-scaling based on Prometheus alerts:

<!-- command -->
```
keptn add-resource --project=sockshop --stage=production --service=carts --resource=remediation.yaml --resourceUri=remediation.yaml
```

This is the content of the file that has being added:

```
apiVersion: spec.keptn.sh/0.1.4
kind: Remediation
metadata:
  name: carts-remediation
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

## Generate load for the service
Duration: 3:00

To simulate user traffic that is causing an unhealthy behavior in the carts service, please execute the following script. This will add special items into the shopping cart that cause some extensive calculation.

1. Move to the correct folder for the load generation scripts:

    <!-- command -->
    ```
    cd ../load-generation/cartsloadgen/deploy
    ```

1. Start the load generation script: 

    <!-- command -->
    ```
    kubectl apply -f cartsloadgen-faulty.yaml
    ```

1. (optional:) Verify the load in Prometheus.
    - Make a port forward to access Prometheus:

    ```
    kubectl port-forward svc/prometheus-service -n monitoring 8080:8080
    ```
    
    - Access Prometheus from your browser on [http://localhost:8080](http://localhost:8080).

    - In the **Graph** tab, add the expression 

    ```
    histogram_quantile(0.9, sum by(le) (rate(http_response_time_milliseconds_bucket{job="carts-sockshop-production"}[3m])))
    ```
    
    - Select the **Graph** tab to see your Response time metrics of the `carts` service in the `sockshop-production` environment.

    - You should see a graph which locks similar to this:

    ![Prometheus load](./assets/prometheus-load.png)


## Watch self-healing in action
Duration: 10:00

After approximately 10-15 minutes, the *Alert Manager* will send out an alert since the *service level objective* is not met anymore. 

To verify that an alert was fired, select the *Alerts* view where you should see that the alert `response_time_p90` is in the `firing` state:

  ![Alert Manager](./assets/alert-manager.png)

After receiving the problem notification, the *prometheus-service* will translate it into a Keptn CloudEvent. This event will eventually be received by the *remediation-service* that will look for a remediation action specified for this type of problem and, if found, execute it.

In this tutorial, the number of pods will be increased to remediate the issue of the response time increase. 

1. Check the executed remediation actions by executing:

    <!-- bash wait_for_pod_number_in_deployment_in_namespace "carts-primary" "2" "sockshop-production" -->

    <!-- debug -->
    ```
    kubectl get deployments -n sockshop-production
    ```

    You can see that the `carts-primary` deployment is now served by two pods:

    ```
    NAME             DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
    carts-db         1         1         1            1           37m
    carts-primary    2         2         2            2           32m
    ```

1. Also you should see an additional pod running when you execute:

    <!-- debug -->
    ```
    kubectl get pods -n sockshop-production
    ```

    ```
    NAME                              READY   STATUS    RESTARTS   AGE
    carts-db-57cd95557b-r6cg8         1/1     Running   0          38m
    carts-primary-7c96d87df9-75pg7    2/2     Running   0          33m
    carts-primary-7c96d87df9-78fh2    2/2     Running   0          5m
    ```

1. To get an overview of the actions that got triggered by the response time SLO violation, you can use the Keptn's Bridge.

    In this example, the bridge shows that the remediation service triggered an update of the configuration of the carts service by increasing the number of replicas to 2. When the additional replica was available, the wait-service waited for ten minutes for the remediation action to take effect. Afterwards, an evaluation by the lighthouse-service was triggered to check if the remediation action resolved the problem. In this case, increasing the number of replicas achieved the desired effect, since the evaluation of the service level objectives has been successful.
    
    ![Bridge - Remediation](./assets/bridge-remediation-flow1.png)
    ![Bridge - Remediation](./assets/bridge-remediation-flow2.png)

1. Furthermore, you can use Prometheus to double-check the response time:

    ![Prometheus](./assets/prometheus-load-reduced.png)

1. Also, the Prometheus Alert Manager will show zero active alerts.

    ![prometheus](./assets/prometheus-alerts-zero.png)