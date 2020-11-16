summary: Azure DevOps with Keptn
id: keptn-azure-devops-07
categories: AKS,quality-gates,dynatrace
tags: keptn07x
status: Submitted
authors: Jürgen Etzlstorfer
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials

# Azure DevOps Pipelines with Keptn Quality Gates

## Welcome
Duration: 00:02:00

![keptn on azure devops](./assets/azure-devops/azure-devops-keptn.png)


In this tutorial, we are going integrate Keptn Quality Gates in your Azure DevOps release pipelines. 


### What you'll learn

1. Install Keptn for a quality gates use case on Azure Kubernetes Service (AKS)
1. Create a project and service in Keptn
1. Define Service Level Indicators (SLIs) to fetch metrics from Dynatrace
1. Define Service Level Objectives (SLOs) to verify quality of deployed services
1. Set up testing and evaluation pipeline in Azure DevOps
1. Deploy app with Azure DevOps pipeline
1. See Keptn quality gates in action

We are going to use the **[Azure DevOps Keptn integration](https://github.com/keptn-sandbox/keptn-azure-devops-extension)** for this.

### Workflow

At the end of the tutorial, our environment will look like this:

![demo workflow](./assets/azure-devops/azure-devops-demo-workflow.png)

## Integrate Keptn in Azure DevOps
Duration: 20:00

We will merge the instructions from the Azure DevOps integration Github repository over to this tutorial format. 
But as for now - please walk over and follow the steps as described on the [Azure DevOps Integration Github repository](https://github.com/keptn-sandbox/keptn-azure-devops-extension).


{{ snippets/07/community/feedback.md }}
