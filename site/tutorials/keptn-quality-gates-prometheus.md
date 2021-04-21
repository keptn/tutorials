summary: Keptn Quality Gates with Prometheus
id: keptn-quality-gates-prometheus
categories: prometheus,aks,eks,openshift,pks,minikube,gke,quality-gates
tags: keptn06x
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials



# Keptn Quality Gates with Prometheus

## Welcome
Duration: 5:00

Let's say you want to use your existing tools to deploy and test your applications - you can still use *Keptn`s Quality Gates* for the evaluation of Service Level Objectives (SLOs).

*A brief recap of SLO and SLI:* A Service Level Objective (SLO) is a target value or range of values for a service level that is measured by a Service Level Indicator (SLI). An SLI is a carefully defined quantitative measure of some aspect of the level of service that is provided. By default, the following SLIs can be used for evaluation, inspired by the [Site Reliability Engineering](https://landing.google.com/sre/sre-book/chapters/service-level-objectives) book from Google:

* *Response time*: The time it takes for a service to execute and complete a task or how long it takes to return a response to a request.
* *System throughput*: The number of requests per second that have been processed.
* *Error rate*: The fraction of all received requests that produced an error.

Positive
: For more information about SLO and SLI, please take a look at [Specifications for Site Reliability Engineering with Keptn](https://github.com/keptn/spec/blob/0.1.3/sre.md).

### What you'll learn

- Learn how to define and use service-level indicators (SLIs) and service-level objectives (SLOs)
- Integrate Keptn Quality Gates in your existing CI/CD pipeline
- How to use the Keptn CLI to trigger the quality gate evaluation
- How to use the Keptn API to trigger the quality gate evaluation



## Install Keptn

