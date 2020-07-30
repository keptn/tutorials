summary: Progressive Delivery with Keptn using Dynatrace
id: keptn-progressive-delivery-dynatrace-07
categories: Dynatrace,aks,eks,gke,openshift,pks,minikube,full-tour,quality-gates
tags: keptn07x
status: Published 
authors: Andreas Grabner
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials


# Progressive Delivery with Keptn using Dynatrace

## Welcome
Duration: 2:00 

In this tutorial you'll get a full tour of setting up Keptn for multi-stage progressive delivery for a node-js based microservice application.
The tutorial also gives you insights into load test automation and extending SLIs/SLOs with Load Test specific metrics gathered through Dynatrace Calculated Metrics!
Alright - here is the complete overview on what you will learn:

![](./assets/simplenode/overview_animated.gif)

You can also watch a recording of an online workshop titled [Setting up Event-based Progressive Delivery with Keptn on k8s](https://www.youtube.com/watch?v=ZuTr_enelM0)


### What you'll learn
- How to create a Keptn project for multi-stage delivery
- How to onboard a container based microservice
- How to deploy your first version of the microservice with blue/green deployments
- How to setup a basic SLI/SLO-based quality gate between staging and production 
- How to define automated performance tests as part of the quality gate
- How to prevent bad builds of your microservice to reach production
- How to extend SLIs & SLOs with advanced Dynatrace metrics
- How to create a Dynatrace Performance Insights Dashboard
- How to integrate other tools like Slack, MS Team, etc in your Keptn integration

You'll find a time estimate until the end of this tutorial in the right top corner of your screen - this should give you guidance how much time is needed for each step.

## Prerequisites
Duration: 5:00

Before you can get started, please make sure to have Keptn installed on your Kubernetes cluster.

If not, please [follow one of these tutorials to install Keptn](../../?cat=installation) on your favourite Kubernetes distribution.

What you need in order to complete this tutorial is
1: keptn status needs to successfully connect to your keptn instance
2: kubectl needs to be configured to connect to your k8s cluster
3: you have access to the Keptns Bridge. If you have not yet exposed it please do so as described in [Expose Keptn's Bridge](https://keptn.sh/docs/0.6.0/reference/keptnsbridge/#expose-lockdown-bridge)

<!-- include other files -->

{{ snippets/07/monitoring/setupDynatrace.md }}

{{ snippets/07/manage/simplenode/createProject.md }}

{{ snippets/07/manage/simplenode/onboardService.md }}

{{ snippets/07/manage/simplenode/validateFirstServiceDeployment.md }}

{{ snippets/07/monitoring/simplenode/validateMonitoringData.md }}

{{ snippets/07/monitoring/simplenode/setupDynatraceSLIProvider.md }}

{{ snippets/07/quality-gates/simplenode/setupBasicQualityGate.md }}

{{ snippets/07/quality-gates/simplenode/setupQualityGateInProd.md }}

{{ snippets/07/quality-gates/simplenode/validateQualityGatesWithMultipleDeployments.md }}

{{ snippets/07/quality-gates/simplenode/extendQualityGatesWithTestMetrics.md }}

{{ snippets/07/monitoring/simplenode/createLoadTestingDashboard.md }}


## Finish
Duration: 1:00

Thanks for taking a full tour through Keptn!
Although Keptn has even more to offer that should have given you a good overview what you can do with Keptn.

### What we've covered

You should have been able to achieve exactly what is shown in the following animated gif!

![](./assets/simplenode/overview_animated.gif)

If you have more questions you can also watch a recording of an online workshop titled [Setting up Event-based Progressive Delivery with Keptn on k8s](https://www.youtube.com/watch?v=ZuTr_enelM0)


{{ snippets/07/integrations/gettingStarted.md }}

{{ snippets/07/community/feedback.md }}
