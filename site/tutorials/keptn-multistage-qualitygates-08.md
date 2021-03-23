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
