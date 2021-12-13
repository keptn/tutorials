summary: Quickstart: Keptn and Prometheus
id: keptn-quickstart-011
categories: prometheus,quickstart,k3s
tags: prometheus,keptn11x,quickstart
status: Published 
authors: Jürgen Etzlstorfer, Oleg Nenashev
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials

# Quickstart: Keptn and Prometheus

## Welcome 
Duration: 0:30

Learn how to get Keptn running in thirty minutes with Prometheus. We'll run Keptn on a local k3d cluster. This quickstart is designed for Linux-based systems. Consequently, use Linux, MacOS, or Windows subsystem for Linux (WSL2).

## Prerequisites

You will need several tools to install Keptn and Prometheus locally: git, k3d, docker, kubectl and helm. You will need to use Linux, MacOS, or Windows subsystem for Linux (WSL2). Note that Docker for Mac may require special licensing if you want to follow this tutorial.

See the installation and configuration guide [here](https://keptn.sh/docs/quickstart/#prerequisites).

## Install Keptn

First of all, you will need to create a cluster for Keptn, and then install and configure Keptn itself. We provide scripts that make it a very quick task as long as you have all tools from _Prerequisites_ ready. 

Follow [these guidelines](https://keptn.sh/docs/quickstart/#install-keptn) to install Keptn.

## Try out Multi-Stage Delivery

Keptn allows to define multi-stage delivery workflows by just declaring what needs to be done. **How to** achieve this delivery workflow is then left to other components and also here Keptn provides deployment services, which allow you to setup a multi-stage delivery workflow without a single line of pipeline code.

The definition is manifested in a so-called **shipyard file** that defines a task sequence for delivery. It can hold multiple stages, each with a dedicated deployment strategy, test strategy, as well as a remediation strategy. Keptn takes the shipyard file and creates a multi-stage workflow each stage having a deployment strategy (e.g., blue/green), testing strategy (e.g., functional tests or performance tests), and an optional automated remediation strategy for triggering self-healing actions.

If you are interested, try out _Multi-stage delivery_ as documented [here](https://keptn.sh/docs/quickstart/#try-multi-stage-delivery).

## Try out Auto-Remediation

In modern microservices environments, you have to deal with systems that can expose unpredictable behavior due to the high number of interdependencies. For example, changing the configuration of one component might have an impact on a different part of the system. Besides, problems evolve and are often dynamic. The nature and impact of a problem can also change drastically over time. Keptn addresses this challenge by introducing the concept of micro-operations that declare remediation actions for resolving certain problem types or triggering any operational tasks.

If you are interested, try it out as documented [here](https://keptn.sh/docs/quickstart/#try-auto-remediation).

## Explore Keptn

You have a running Keptn instance, so you can browse through the web interface and try out more features while around. Also have a look at our tutorials and documentation to learn how you can use Keptn.

You can find some references and suggestions [here](https://keptn.sh/docs/quickstart/#explore-keptn).

## Stop Keptn

If you are finished exploring Keptn, you can always stop and start the cluster and delete it eventually.

```bash
k3d cluster stop mykeptn
k3d cluster start mykeptn
```

Or delete it if you don’t need it anymore

```bash
k3d cluster delete mykeptn
```

{{ snippets/11/community/feedback.md }}
