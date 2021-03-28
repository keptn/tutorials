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

