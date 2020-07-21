summary: Take a full tour on Keptn with Prometheus
id: keptn-full-tour-prometheus-07
categories: Prometheus,aks,eks,gke,openshift,pks,minikube,full-tour,quality-gates,automated-operations
tags: keptn07x
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials


# Keptn Full Tour on Prometheus

## Welcome
Duration: 2:00 

In this tutorial you'll get a full tour through Keptn. Before we get started you'll get to know what you will learn while you walk yourself through this tutorial.

### What you'll learn
- How to create a sample project
- How to onboard a first microservice
- How to deploy your first microservice with blue/green deployments
- How to setup quality gates 
- How to prevent bad builds of your microservice to reach production
- How to automatically scale your microservice with Keptn 
- How to integrate other tools like Slack, MS Team, etc in your Keptn integration

You'll find a time estimate until the end of this tutorial in the right top corner of your screen - this should give you guidance how much time is needed for each step.

In this tutorial, we are going to install Keptn on a Kubernetes cluster, along with Istio for traffic routing and ingress control.

{{ snippets/07/install/cluster.md }}

{{ snippets/07/install/istio.md }}

{{ snippets/07/install/download-keptnCLI.md }}

{{ snippets/07/install/install-full.md }}

{{ snippets/07/install/configureIstio.md }}

{{ snippets/07/install/authCLI-istio.md }}

{{ snippets/07/manage/createProject.md }}

{{ snippets/07/manage/onboardService.md }}

{{ snippets/07/monitoring/setupPrometheus.md }}

{{ snippets/07/monitoring/install-sli-provider-prometheus.md }}

{{ snippets/07/quality-gates/setupQualityGate.md }}

{{ snippets/07/self-healing/upscalePrometheus.md }}


## Finish
Duration: 1:00

Thanks for taking a full tour through Keptn!
Although Keptn has even more to offer that should have given you a good overview what you can do with Keptn.

### What we've covered

- We have created a sample project with the Keptn CLI and set up a multi-stage delivery pipeline with the `shipyard` file
  ```
  stages:
    - name: "dev"
      deployment_strategy: "direct"
      test_strategy: "functional"
    - name: "staging"
      approval_strategy: 
        pass: "automatic"
        warning: "automatic"
      deployment_strategy: "blue_green_service"
      test_strategy: "performance"
    - name: "production"
      approval_strategy: 
        pass: "automatic"
        warning: "manual"
      deployment_strategy: "blue_green_service"
      remediation_strategy: "automated"
  ```

- We have set up quality gates based on service level objectives in our `slo` file
  ```
  ---
  spec_version: "1.0"
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


- We have tested our quality gates by deploying a bad build to our cluster and verified that Keptn quality gates stopped them.
  ![bridge](./assets/bridge-quality-gate.png)


- We have set up self-healing to automatically scale our application 
  ![Bridge - Remediation](./assets/bridge-remediation-flow.png)

{{ snippets/07/integrations/gettingStarted.md }}

{{ snippets/07/community/feedback.md }}
