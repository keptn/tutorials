summary: Keptn Quality Gates with Dynatrace
id: keptn-quality-gates-dynatrace-07-on-k3s
categories: Dynatrace,k3s,quality-gates
tags: keptn07x
status: Published
authors: Andreas Grabner
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials


# Keptn Quality Gates with Dynatrace in 5 Minutes using k3s

## Welcome
Duration: 2:00

If you have tools that deploy your applications and then run tests against those you have done the hard work already. *Keptn's Quality Gates* help you to automate the evaluation of your test results and the monitoring data captured during your tests. Keptn does this by embracing the concept of Service Level Indicators (SLIs) and Service Level Objectives (SLOs). Essentially SLIs are metrics such as Response Time, Throughput, Error Rate, Number of Database Calls, Time spent in external service calls, ... and SLOs define which objective you have for these SLIs to consider your service to be adhering to what you expect, e.g: Response Time of Login should be faster than 200ms or Login should not make more than 1 database query.
Keptn didn't come up with these concepts. They have been around for a while and made very popular thanks to the work that Google did around [Site Reliability Engineering](https://landing.google.com/sre/sre-book/chapters/service-level-objectives)

In this tutorial we teach you how you can use Keptn Quality Gates to automatically analyze important metrics (SLIs) that Dynatrace captures while your system is under load, e.g: during a load test and compare them against your expected behavior (SLOs). This comparison can either be against well defined thresholds, e.g: 200ms response time but can also be a comparison against previous test results, e.g: response time should not get slower than 10% of our previous build.

The real benefit is visualized in the following animation. Keptn Quality Gates help you automate the manual task of analyzing or comparing data on dashboards to determine whether a build meets your quality criteria.

![](./assets/dynatrace_qualitygates/dynatrace_keptn_sli_automation.gif)

## GitHub Tutorial for Quality Gates
Duration: 5:00

We have initially created this tutorial on the [Keptn Quality Gates for Dynatrace User in 5 Minutes](https://github.com/keptn-sandbox/keptn-on-k3s/blob/master/README-KeptnForDynatrace.md) GitHub page. We will merge it over to this tutorial format. As for now - please walk over and follow the steps as described [here](https://github.com/keptn-sandbox/keptn-on-k3s/blob/master/README-KeptnForDynatrace.md)

Once you install Keptn based on the installation instructions you will automatically get a pre-configured quality gate project connected to your Dynatrace Environment which is ready to run quality gates:
![](./assets/dynatrace_qualitygates/keptn_on_k3s_qualitygate_bridge.png)

This tutorial already uses the new Dynatrace SLO Dashboard capabilities which pull data from a dashboard that looks like this:
![](./assets/dynatrace_qualitygates/keptn_on_k3s_qualitygate_slo_dashboard.png)

To summarize - here is why you should run the [GitHub tutorial](https://github.com/keptn-sandbox/keptn-on-k3s/blob/master/README-KeptnForDynatrace.md):
* You only need a Linux machine with 4GB RAM & 1vCPU to setup keptn
* You can explore to the Dynatrace SLO dashboard capability of Keptn
* You can immediately run your quality after the installation completes

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

{{ snippets/07/community/feedback.md }}
