
## Set up the quality gate
Duration: 5:00

Keptn requires a performance specification for the quality gate. This specification is described in a file called `slo.yaml`, which specifies a Service Level Objective (SLO) that should be met by a service. To learn more about the *slo.yaml* file, go to [Specifications for Site Reliability Engineering with Keptn](https://github.com/keptn/spec/blob/0.1.3/sre.md).

Activate the quality gates for the carts service. Therefore, navigate to the `examples/onboarding-carts` folder and upload the `slo-quality-gates.yaml` file using the [add-resource](../../reference/cli/#keptn-add-resource) command:

```
keptn add-resource --project=sockshop --stage=staging --service=carts --resource=slo-quality-gates.yaml --resourceUri=slo.yaml
```

This will add the `SLO.yaml` file to your Keptn - which is the declaritive definition of a quality gate. Let's take a look at the file contents:

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

## Deploy a slow build
Duration: 5:00

You can take a look at the currently deployed version of our "carts" microservice before we deploy the next build of our microservice.

1. Get the URL for your carts service with the following commands in the respective stages:

```
echo http://carts.sockshop-dev.$(kubectl get cm keptn-domain -n keptn -o=jsonpath='{.data.app_domain}')
```

```
echo http://carts.sockshop-staging.$(kubectl get cm keptn-domain -n keptn -o=jsonpath='{.data.app_domain}')
```

```
echo http://carts.sockshop-production.$(kubectl get cm keptn-domain -n keptn -o=jsonpath='{.data.app_domain}')
```

2. Navigate to `http://carts.sockshop-production.YOUR.DOMAIN` for viewing the carts service in your **production** environment and you should receive an output similar to the following:

![carts service](./assets/carts-production-1.png)


## Deploy the slow carts version
Duration: 5:00


1. Use the Keptn CLI to deploy a version of the carts service, which contains an artificial **slowdown of 1 second** in each request.

```
keptn send event new-artifact --project=sockshop --service=carts --image=docker.io/keptnexamples/carts --tag=0.10.2
```

2. Go ahead and verify that the slow build has reached your `dev` and `staging` environments by opening a browser for both environments. Get the URLs with these commands:

```
echo http://carts.sockshop-dev.$(kubectl get cm keptn-domain -n keptn -o=jsonpath='{.data.app_domain}')
```

```
echo http://carts.sockshop-staging.$(kubectl get cm keptn-domain -n keptn -o=jsonpath='{.data.app_domain}')
```


![carts service](./assets/carts-dev-2.png)

![carts service](./assets/carts-staging-2.png)


## Quality gate in action
Duration: 10:00 

After triggering the deployment of the carts service in version v0.10.2, the following status is expected:

* **Dev stage:** The new version is deployed in the dev stage and the functional tests passed.
  * To verify, open a browser and navigate to: `http://carts.sockshop-dev.YOUR.DOMAIN`

* **Staging stage:** In this stage, version v0.10.2 will be deployed and the performance test starts to run for about 10 minutes. After the test is completed, Keptn triggers the test evaluation and identifies the slowdown. Consequently, a roll-back to version v0.10.1 in this stage is conducted and the promotion to production is not triggered.
  * To verify, the [Keptn's Bridge](https://keptn.sh/docs/0.6.0/reference/keptnsbridge/) shows the deployment of v0.10.2 and then the failed test in staging including the roll-back:

TODO 

![Quality gate in staging](./assets/quality_gates.png)

* **Production stage:** The slow version is **not promoted** to the production stage because of the active quality gate in place. Thus, still version v0.10.1 is expected to be in production.
  * To verify, navigate to: `http://carts.sockshop-production.YOUR.DOMAIN`


## Verify the quality gate in Keptn's Bridge
Duration: 3:00

TODO

![Keptn's bridge](./assets/quality-gates-bridge.png)



## Deploy a regular carts version
Duration: 3:00

1. Use the Keptn CLI to send a new version of the *carts* artifact, which does **not** contain any slowdown:
  ```
  keptn send event new-artifact --project=sockshop --service=carts --image=docker.io/keptnexamples/carts --tag=0.10.3
  ```

1. To verify the deployment in *production*, open a browser and navigate to `http://carts.sockshop-production.YOUR.DOMAIN`. As a result, you see `Version: v3`.

1. Besides, you can verify the deployments in your Kubernetes cluster using the following commands: 
  ```
  kubectl get deployments -n sockshop-production
  ``` 

  ```
  NAME            DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
  carts-db        1         1         1            1           63m
  carts-primary   1         1         1            1           98m
  ```

  ```
  kubectl describe deployment carts-primary -n sockshop-production
  ``` 
  
  ```
  ...
  Pod Template:
    Labels:  app=carts-primary
    Containers:
      carts:
        Image:      docker.io/keptnexamples/carts:0.10.3
  ```


