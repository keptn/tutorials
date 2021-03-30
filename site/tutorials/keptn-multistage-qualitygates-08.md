summary: Multistage deployment with Quality Gates using Prometheus
id: keptn-multistage-qualitygates-08
categories: Prometheus,aks,eks,gke,openshift,pks,minikube,full-tour,quality-gates,automated-operations
tags: keptn08x
status: Published
authors: Gabriel Tanner
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials

# Multistage deployment with Quality Gates using Prometheus

## Welcome
Duration: 2:00

In this tutorial we'll set up a demo application which will feature different Prometheus metrics and deploy the application using multistage delivery. We will then use Keptn quality gates to evaluate the resilience of the application based on SLO-driven quality gates.

### What we will cover

- How to create a sample project and onboard a sample service
- How to setup quality gates
- How to use Prometheus metrics in our SLIs & SLOs
- How to prevent bad builds of your microservice to reach production

In this tutorial, we are going to install Keptn on a Kubernetes cluster.

The full setup that we are going to deploy is sketched in the following image.

![demo setup](./assets/keptn-multistage-podtatohead/demo-workflow.png)

{{ snippets/08/install/cluster.md }}

{{ snippets/08/install/istio.md }}

{{ snippets/08/install/download-keptnCLI.md }}

{{ snippets/08/install/install-full.md }}

{{ snippets/08/install/configureIstio.md }}

{{ snippets/08/install/authCLI-istio.md }}

## Download the demo resources
Duration: 1:00

The demo resources can be found on Github for a convenient experience. Let's clone the project's repository, so we have all the resources needed to get started.

```
git clone https://github.com/cncf/podtato-head.git
```

Now, let's switch to the directory including the demo resources.

```
cd podtato-head/delivery/keptn
```

## Create project
Duration: 1:00

A project in Keptn is the logical unit that can hold multiple (micro)services. Therefore, it is the starting point for each Keptn installation.
We have already cloned the demo resources from Github, so we can go ahead and create the project.

**Recommended:** Create a new project with Git upstream:

To configure a Git upstream for this tutorial, the Git user (`--git-user`), an access token (`--git-token`), and the remote URL (`--git-remote-url`) are required. If a requirement is not met, go to [the Keptn documentation](https://keptn.sh/docs/0.8.0/manage/git_upstream/) where instructions for GitHub, GitLab, and Bitbucket are provided.

Let's define the variables before running the command:

<!-- bash keptn create project litmus --shipyard=./shipyard.yaml -->

```
GIT_USER=gitusername
GIT_TOKEN=gittoken
GIT_REMOTE_URL=remoteurl
```

Now let's create the project using the `keptn create project` command.

```
keptn create project pod-tato-head --shipyard=./shipyard.yaml --git-user=$GIT_USER --git-token=$GIT_TOKEN --git-remote-url=$GIT_REMOTE_URL
```

**Alternatively:** If you don't want to use a Git upstream, you can create a new project without it but please note that this is not the recommended way:

```
keptn create project pod-tato-head --shipyard=./shipyard.yaml
```

For creating the project, the tutorial relies on a `shipyard.yaml` file as shown below:

```
apiVersion: "spec.keptn.sh/0.2.0"
kind: "Shipyard"
metadata:
  name: "shipyard-sockshop"
spec:
  stages:
    - name: "hardening"
      sequences:
        - name: "delivery"
          tasks:
            - name: "deployment"
              properties:
                deploymentstrategy: "blue_green_service"
            - name: "test"
              properties:
                teststrategy: "performance"
            - name: "evaluation"
            - name: "release"
    - name: "production"
      sequences:
        - name: "delivery"
          triggeredOn:
            - event: "hardening.delivery.finished"
          tasks:
            - name: "deployment"
              properties:
                deploymentstrategy: "blue_green_service"
            - name: "release"
```

In the `shipyard.yaml` shown above, we define two stages called *hardening* and *production* with a single sequence called *delivery*. The *hardening* stage defines a *delivery* sequence with a deployment, test, evaluation and release task (along with some other properties) while the *production* stage only includes a deloyment and release task. The *production* stage also features a *triggeredOn* properties which defines when the stage will be executed (in this case after the hardening stage has finished the delivery sequence). With this, Keptn sets up the environment and makes sure, that tests are triggered after each deployment, and the tests are then evaluated by Keptn quality gates. Keptn performs a blue/green deployment (i.e., two deployments simultaneously with routing of traffic to only one deployment) and triggers a performance test in the hardening stage. Once the tests complete successfully, the deployment moves into the production stage using another blue/green deployment.

## Onboard service
Duration: 2:00

After creating the project, we can continue by onboarding the *helloserver* as a service to your project using the `keptn onboard service` command and passing the project you want to onboard the service to as well as the Helm chart of the service.

```
keptn onboard service helloservice --project="pod-tato-head" --chart=helm-charts/helloserver
```

After onboarding the service, tests (i.e., functional- and performance tests) need to be added as basis for quality gates. We are using JMeter tests, as the JMeter service comes "batteries included" with our Keptn installation.

```
keptn add-resource --project=pod-tato-head --stage=hardening --service=helloservice --resource=jmeter/load.jmx --resourceUri=jmeter/load.jmx
keptn add-resource --project=pod-tato-head --stage=hardening --service=helloservice --resource=jmeter/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml
```

Now each time Keptn triggers the test execution, the JMeter service will pick up both files and execute the tests.

## Deploy first build with Keptn
Duration: 4:00

We are now ready to kick off a new deployment of our test application with Keptn and have it deployed, tested, and evaluated.

1. Let us now trigger the deployment, tests, and evaluation of our demo application.

    ```
    keptn trigger delivery --project="pod-tato-head" --service=helloservice --image="gabrieltanner/hello-server" --tag=v0.1.1
    ```

1. Let's have a look in the Keptn bridge what is actually going on. We can use this helper command to retrieve the URL of our Keptn bridge.

    ```
    echo http://$(kubectl -n keptn get ingress api-keptn-ingress -ojsonpath='{.spec.rules[0].host}')/bridge
    ```

    The credentials can be retrieved via the Keptn CLI:

    ```
    keptn configure bridge --output
    ```

    ![](./assets/keptn-multistage-podtatohead/podtato-head-first-deployment-bridge.png)

1. **Optional:** Verify the pods that should have been created for the helloservice

    ```
    kubectl get pods --all-namespaces | grep helloservice
    ```

    ```
    pod-tato-head-hardening    helloservice-primary-5f779966f9-vjjh4                        2/2     Running   0          4m55s
    pod-tato-head-production   helloservice-primary-5f779966f9-kbhz5                        2/2     Running   0          2m52s
    ```

## View helloservice

You can get the URL for the helloservice with the following commands in the respective namespaces:

Hardening:

```
echo http://helloservice.pod-tato-head-hardening.$(kubectl -n keptn get ingress api-keptn-ingress -ojsonpath='{.spec.rules[0].host}')
```

Production:

```
echo http://helloservice.pod-tato-head-production.$(kubectl -n keptn get ingress api-keptn-ingress -ojsonpath='{.spec.rules[0].host}')
```

Navigating to the URLs should result in the following output:

![](./assets/keptn-multistage-podtatohead/podtato-head-first-deployment.png)

## Setup Prometheus Monitoring
Duration: 3:00

After creating a project and service, you can setup Prometheus monitoring and configure scrape jobs using the Keptn CLI.

To install the *prometheus-service*, execute:

<!-- command -->
```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-service/release-0.4.0/deploy/service.yaml
```

<!-- 
bash wait_for_deployment_in_namespace "prometheus-service" "keptn" 
bash wait_for_deployment_in_namespace "prometheus-service-monitoring-configure-distributor" "keptn" 
sleep 10
-->
    
Negative
: Please note that a Keptn managed Prometheus will be installed only after executing the next command. At this step, we have only installed the service that is responsible for managing Prometheus.

Execute the following command to install Prometheus and set up the rules for the *Prometheus Alerting Manager*:

<!-- command -->
```
keptn configure monitoring prometheus --project=pod-tato-head --service=helloservice
```

<!-- bash wait_for_deployment_in_namespace "alertmanager" "monitoring" -->
<!-- bash wait_for_deployment_in_namespace "prometheus-deployment" "monitoring" -->

### Optional: Verify Prometheus setup in your cluster

- To verify that the Prometheus scrape jobs are correctly set up, you can access Prometheus by enabling port-forwarding for the prometheus-service:

    ```
    kubectl port-forward svc/prometheus-service 8080 -n monitoring
    ```

Prometheus is then available on [localhost:8080/targets](http://localhost:8080/targets) where you can see the targets for the service:
![Prometheus targets](./assets/prometheus-targets.png")

## Setup Prometheus SLI provider
Duration: 2:00

During the evaluation of a quality gate, the Prometheus SLI provider is required that is implemented by an internal Keptn service, the *prometheus-sli-service*. This service will _fetch the values_ for the SLIs that are referenced in an SLO configuration file.

To install the *prometheus-sli-service*, execute:

<!-- command -->
```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-sli-service/release-0.3.0/deploy/service.yaml
```

We are going to add the configuration for our SLIs in terms of an SLI file that maps the _name_ of an indicator to a PromQL statement how to actually query it.

<!-- command -->
```
keptn add-resource --project=pod-tato-head --stage=hardening --service=helloservice --resource=prometheus/sli.yaml --resourceUri=prometheus/sli.yaml
```

For your information, the contents of the file are as follows:
```
---
spec_version: '1.0'
indicators:
  http_response_time_seconds_main_page_sum: sum(rate(http_server_request_duration_seconds_sum{method="GET",route="/",status_code="200",job="$SERVICE-$PROJECT-$STAGE-canary"}[$DURATION_SECONDS])/rate(http_server_request_duration_seconds_count{method="GET",route="/",status_code="200",job="$SERVICE-$PROJECT-$STAGE-canary"}[$DURATION_SECONDS]))
  http_requests_total_sucess: http_requests_total{status="success"}
  go_routines: go_goroutines{job="$SERVICE-$PROJECT-$STAGE"}
  request_throughput: sum(rate(http_requests_total{status="success"}[$DURATION_SECONDS]))
```

## Set up the quality gate
Duration: 4:00

Keptn requires a performance specification for the quality gate. This specification is described in a file called `slo.yaml`, which specifies a Service Level Objective (SLO) that should be met by a service. To learn more about the *slo.yaml* file, go to [Specifications for Site Reliability Engineering with Keptn](https://github.com/keptn/spec/blob/master/service_level_objective.md).

Activate the quality gates for the helloservice. Therefore, navigate to the `delivery/keptn` folder and upload the `slo.yaml` file using the [add-resource](https://keptn.sh/docs/0.8.x/reference/cli/commands/keptn_add-resource/) command:

<!-- command -->

```
keptn add-resource --project=pod-tato-head --stage=hardening --service=helloservice --resource=slo.yaml --resourceUri=slo.yaml
```

This will add the `slo.yaml` file to your Keptn - which is the declaritive definition of a quality gate. Let's take a look at the file contents:

```
---
spec_version: '0.1.0'
comparison:
  compare_with: "single_result"
  include_result_with_score: "pass"
  aggregate_function: avg
objectives:
  - sli: http_response_time_seconds_main_page_sum
    pass:
      - criteria:
          - "<=1"
    warning:
      - criteria:
          - "<=0.5"
  - sli: request_throughput
    pass:
      - criteria:
          - "<=+100%"
          - ">=-80%"
  - sli: go_routines
    pass:
      - criteria:
          - "<=100"
total_score:
  pass: "90%"
  warning: "75%"
```
