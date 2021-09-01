
## Onboard first microservice
Duration: 5:00

After creating the project, services can be onboarded to our project.

1. Onboard the **carts** service using the [keptn onboard service](https://keptn.sh/docs/0.9.x/reference/cli/commands/keptn_onboard_service/) command:

    <!-- command -->
    ```
    keptn onboard service carts --project=sockshop --chart=./carts
    ```

1. After onboarding the service, tests (i.e., functional- and performance tests) need to be added as basis for quality gates in the different stages:

  * Functional tests for *dev* stage:

    <!-- command -->
    ```
    keptn add-resource --project=sockshop --stage=dev --service=carts --resource=jmeter/basiccheck.jmx --resourceUri=jmeter/basiccheck.jmx
    ```

  * Performance tests for *staging* stage:

    <!-- command -->
    ```
    keptn add-resource --project=sockshop --stage=staging --service=carts --resource=jmeter/load.jmx --resourceUri=jmeter/load.jmx
    ```

    **Note:** You can adapt the tests in `basiccheck.jmx` as well as `load.jmx` for your service. However, you must not rename the files because there is a hardcoded dependency on these file names in the current implementation of Keptn's jmeter-service. 

Since the carts service requires a mongodb database, a second service needs to be onboarded.

* Onboard the **carts-db** service using the [keptn onboard service](https://keptn.sh/docs/0.9.x/reference/cli/commands/keptn_onboard_service/) command.

    <!-- command -->
    ```
    keptn onboard service carts-db --project=sockshop --chart=./carts-db
    ```

Take a look in your Keptn's Bridge and see the newly onboarded services.
![bridge services](./assets/bridge-new-services.png)


## Deploy first build with Keptn 
Duration: 5:00

After onboarding the services, a built artifact of each service can be deployed.

1. Deploy the carts-db service by executing the [keptn trigger delivery](https://keptn.sh/docs/0.9.x/reference/cli/commands/keptn_trigger_delivery/) command:

    <!-- command -->
    ```
    keptn trigger delivery --project=sockshop --service=carts-db --image=docker.io/mongo --tag=4.2.2 --sequence=delivery-direct
    ```

    <!-- bash 
    verify_test_step $? "trigger delivery for carts-db failed"
    wait_for_deployment_with_image_in_namespace "carts-db" "sockshop-production" "docker.io/mongo:4.2.2"
    verify_test_step $? "Deployment carts-db not available, exiting..."
    -->

1. Deploy the carts service by specifying the built artifact, which is stored on DockerHub and tagged with version 0.12.1:

    <!-- command -->
    ```
    keptn trigger delivery --project=sockshop --service=carts --image=docker.io/keptnexamples/carts --tag=0.12.1
    ```

    <!-- bash 
    verify_test_step $? "trigger delivery for carts failed" 
    wait_for_deployment_with_image_in_namespace "carts" "sockshop-production" "docker.io/keptnexamples/carts:0.12.1"
    verify_test_step $? "Deployment carts not available, exiting..."
    -->

1. Go to Keptn's Bridge and check which events have already been generated.
  ![bridge](./assets/bridge.png)


1. **Optional:** Verify the pods that should have been created for services carts and carts-db:

    <!-- debug -->
    ```
    kubectl get pods --all-namespaces | grep carts-
    ```
    
    ```
    sockshop-dev          carts-77dfdc664b-25b74                            1/1     Running     0          10m
    sockshop-dev          carts-db-54d9b6775-lmhf6                          1/1     Running     0          13m
    sockshop-production   carts-db-54d9b6775-4hlwn                          2/2     Running     0          12m
    sockshop-production   carts-primary-79bcc7c99f-bwdhg                    2/2     Running     0          2m15s
    sockshop-staging      carts-db-54d9b6775-rm8rw                          2/2     Running     0          12m
    sockshop-staging      carts-primary-79bcc7c99f-mbbgq                    2/2     Running     0          7m24s
    ```

## View carts service
Duration: 2:00

1. Get the URL for your carts service with the following commands in the respective namespaces:

    - [http://carts.sockshop-dev.apps-crc.testing](http://carts.sockshop-dev.apps-crc.testing)
    - [http://carts.sockshop-staging.apps-crc.testing](http://carts.sockshop-staging.apps-crc.testing)
    - [http://carts.sockshop-production.apps-crc.testing](http://carts.sockshop-production.apps-crc.testing)

1. Navigate to the URLs to inspect the carts service. In the production namespace, you should receive an output similar to this:

  ![carts in production](./assets/carts-production-1.png)


## Generate traffic
Duration: 2:00

Now that the service is running in all three stages, let us generate some traffic so we have some data we can base the evaluation on.

Change the directory to `examples/load-generation/cartsloadgen`. If you are still in the onboarding-carts directory, use the following command or change it accordingly:

<!-- command -->
```
cd ../load-generation/cartsloadgen
```

Now let us deploy a pod that will generate some traffic for all three stages of our demo environment.

<!-- command -->
```
kubectl apply -f deploy/cartsloadgen-base.yaml 
```

<!-- bash sleep 30 -->

The output will look similar to this.
```
namespace/loadgen created
deployment.extensions/cartsloadgen created
```

Optionally, you can verify that the load generator has been started.

<!-- command -->

```
kubectl get pods -n loadgen
```

```
NAME                            READY   STATUS    RESTARTS   AGE
cartsloadgen-5dc47c85cf-kqggb   1/1     Running   0          117s
```



