summary: Keptn Quality Gates with Dynatrace
id: keptn-quality-gates-dynatrace
categories: Dynatrace,aks,eks,openshift,pks,minikube,gke,quality-gates
tags: keptn06x
status: Published
authors: Andreas Grabner
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials


# Keptn Quality Gates with Dynatrace

## Welcome
Duration: 5:00

If you have tools that deploy your applications and then run tests against those you have done the hard work already. *Keptn's Quality Gates* help you to automate the evaluation of your test results and the monitoring data captured during your tests. Keptn does this by embracing the concept of Service Level Indicators (SLIs) and Service Level Objectives (SLOs). Essentially SLIs are metrics such as Response Time, Throughput, Error Rate, Number of Database Calls, Time spent in external service calls, ... and SLOs define which objective you have for these SLIs to consider your service to be adhering to what you expect, e.g: Response Time of Login should be faster than 200ms or Login should not make more than 1 database query.
Keptn didn't come up with these concepts. They have been around for a while and made very popular thanks to the work that Google did around [Site Reliability Engineering](https://landing.google.com/sre/sre-book/chapters/service-level-objectives)

In this tutorial we teach you how you can use Keptn Quality Gates to automatically analyze important metrics (SLIs) that Dynatrace captures while your system is under load, e.g: during a load test and compare them against your expected behavior (SLOs). This comparison can either be against well defined thresholds, e.g: 200ms response time but can also be a comparison against previous test results, e.g: response time should not get slower than 10% of our previous build.

The real benefit is visualized in the following animation. Keptn Quality Gates help you automate the manual task of analyzing or comparing data on dashboards to determine whether a build meets your quality criteria.

![](./assets/dynatrace_qualitygates/dynatrace_keptn_sli_automation.gif)

This tutorial will use a simple node.js based containerized sample application which you will deploy 

### What you'll learn

- Install Keptn and setup a Keptn Project for Quality Gate evaluation
- Prepare Dynatrace to act as a data source for Quality Gate evaluation
- Learn how to define and use service-level indicators (SLIs) and service-level objectives (SLOs)
- How to trigger a Keptn Quality Gate evaluation using the CLI and the API
- How to use the Keptn's Bridge to inspect your Quality Gate Results

## Prerequisites Keptn
Duration: 5:00

Before you can get started, please make sure to have Keptn installed on your Kubernetes cluster.

If not, please [follow one of these tutorials to install Keptn](../../?cat=installation) on your favourite Kubernetes distribution. You can either do a full Keptn installation or can opt in to only install the execution plane for quality-gates by adding --use-case=quality-gates to keptn install. Both installation options will work for our tutorial.

What you need in order to complete this tutorial is
1: keptn status needs to successfully connect to your keptn instance
2: kubectl needs to be configured to connect to your k8s cluster
3: you have access to the Keptn's Bridge. If you have not yet exposed it please do so as described in [Expose Keptn's Bridge](https://keptn.sh/docs/0.6.0/reference/keptnsbridge/#expose-lockdown-bridge)

## Prerequisites Dynatrace & Sample application
Duration: 5:00

This tutorial assumes that you have an application that is already deployed and monitored with Dynatrace. It should also be an application that has some load on it in order for Keptn to pull metrics for the SLI/SLO-based Quality Gate evaluation.
If you do not have an application that is under load follow the next tutorial step. Otherwise you can skip it:

<!-- include other files -->

{{ snippets/06/simplenode/monitorDeployLoadSimplenode.md }}

{{ snippets/06/monitoring/setupDynatrace.md }}

{{ snippets/06/manage/simplenode/createProjectQualityStageOnly.md }}

{{ snippets/06/manage/simplenode/createServiceQualityStageOnly.md }}

{{ snippets/06/monitoring/simplenode/setupDynatraceSLIProviderQualityStageOnly.md }}

{{ snippets/06/quality-gate-only/tagEvalservice.md }}

{{ snippets/06/quality-gate-only/simplenode/setupBasicQualityGate.md }}

{{ snippets/06/quality-gate-only/simplenode/executeQualityGateThroughCLI.md }}

{{ snippets/06/quality-gate-only/simplenode/executeQualityGateThroughAPI.md }}


## Finish
Duration: 0:00

In this tutorial, you have learned how to use Keptn to validate the quality of your deployments by evaluating a set of SLIs (Service Level Indicators) against your SLOs (Service Level Objectives) for a specified timeframe! The overall goal is to use this capability to automate the manual evaluation of metrics through dashboards.

As you have now learned how to setup Keptn for pulling metrics out of Dynatrace the next step is that you do this with metrics that are important for your services, applications, processes and hosts. Think about how you can convert your Dynatrace dashboards into SLIs and SLOs and then have Keptn automate the analysis for you:

![](./assets/dynatrace_qualitygates/dynatrace_keptn_sli_automation.gif)


### What we've covered

- Install Keptn and setup a Keptn Project for Quality Gate evaluation
- Prepare Dynatrace to act as a data source for Quality Gate evaluation
- Learn how to define and use service-level indicators (SLIs) and service-level objectives (SLOs)
- How to trigger a Keptn Quality Gate evaluation using the CLI and the API
- How to use the Keptn's Bridge to inspect your Quality Gate Results

{{ snippets/06/community/feedback.md }}
