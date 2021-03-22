summary: Resilience evaluation with Litmus, Prometheus, and Keptn
id: keptn-litmus-08
categories: Prometheus,aks,eks,gke,openshift,pks,minikube,quality-gates,litmus
tags: keptn08x
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials


# Resilience evaluation with Litmus, Prometheus, and Keptn

## Welcome
Duration: 2:00 

In this tutorial we'll set up a demo application and have it undergo some chaos in combination with load testing. We will then use Keptn quality gates to evaluate the resilience of the application based on SLO-driven quality gates.

### What we will cover
- How to create a sample project
- How to onboard a first microservice
- How to setup quality gates 
- How to add the Litmus integration and execute chaos
- How to evaluate application resilience

You'll find a time estimate until the end of this tutorial in the right top corner of your screen - this should give you guidance how much time is needed for each step.


In this tutorial, we are going to install Keptn on a Kubernetes cluster.

The full setup that we are going to deploy is sketched in the following image.
![demo setup](./assets/keptn-litmus/demo-workflow.png)

If you are interested, please have a look at this presentation from Litmus and Keptn maintainers presenting the intial integration.

![https://www.youtube.com/watch?v=aa5SzQmv4EQ](.)


{{ snippets/08/install/cluster.md }}

{{ snippets/08/install/istio.md }}

{{ snippets/08/install/download-keptnCLI.md }}

{{ snippets/08/install/install-full.md }}

{{ snippets/08/install/configureIstio.md }}

{{ snippets/08/install/authCLI-istio.md }}

## Download demo resources
Duration: 1:00

Demo resources are prepared for you on Github for a convenient experience. We are going to download them to the local machine so we have them handy.

```
git clone --branch=TBD https://github.com/keptn-sandbox/litmus-service.git --single-branch
```

Now switch to the directory including the demo resources.

```
cd litmus-service/test-data
```


## Install Litmus Operator & Chaos CRDs
Duration: 3:00

1. Let us install Litmus into our Kubernetes cluster. This can be done via `kubectl`.

    ```
    kubectl apply -f ./litmus/litmus-operator-v1.13.2.yaml 
    ```

1. We are going to create a namespace where we are later executing our chaos experiments.

    ```
    kubectl create namespace litmus-chaos
    ```

1. We also need to create the custom resources for the experiments we want to run later, as well as some permissions.

    ```
    kubectl apply -f ./litmus/pod-delete-ChaosExperiment-CR.yaml 

    kubectl apply -f ./litmus/pod-delete-rbac.yaml 
    ```

## Setup Prometheus
Duration: 3:00

Before we are going to create the project with Keptn, we'll install the Prometheus integration to be ready to fetch the data that is later on needed for the SLO-based quality gate evaluation. 

1. The Prometheus service integration is responsible to set up Prometheus with Keptn, let us install the integration. Please note, this does **not** automatically install Prometheus - this will be done later in the tutorial.

    ```
    kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-service/release-0.4.0/deploy/service.yaml
    ```

1. Next, we are going to install the Prometheus SLI integration to be able to fetch the data from Prometheus

    ```
    kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/prometheus-sli-service/release-0.3.0/deploy/service.yaml
    ```


## Setup Litmus integration
Duration: 1:00

Similar to the Prometheus integration, we are now adding the Litmus integration. 

1. This can be done via the following command.

```
kubectl apply -f ../deploy/service.yaml
```

We now have all the integrations installed and connected to the Keptn control plane. Let's move on with setup up a project!

## Create project
Duration: 3:00

A project in Keptn is the logical unit that can hold multiple (micro)services. Therefore, it is the starting point for each Keptn installation.

To get all files you need for this tutorial, please clone the example repo to your local machine.

```
git clone --branch=TBD https://github.com/keptn-sandbox/litmus-service.git --single-branch

cd litmus-service/test-data
```

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
keptn create project litmus --shipyard=./shipyard.yaml --git-user=$GIT_USER --git-token=$GIT_TOKEN --git-remote-url=$GIT_REMOTE_URL
```


**Alternatively:** If you don't want to use a Git upstream, you can create a new project without it but please note that this is not the recommended way:

<!-- command -->
```
keptn create project litmus --shipyard=./shipyard.yaml
```


For creating the project, the tutorial relies on a `shipyard.yaml` file as shown below:

```
apiVersion: "spec.keptn.sh/0.2.0"
kind: "Shipyard"
metadata:
  name: "shipyard-litmus-chaos"
spec:
  stages:
    - name: "chaos"
      sequences:
        - name: "delivery"
          tasks:
            - name: "deployment"
              properties:
                deploymentstrategy: "direct"
            - name: "test"
              properties:
                teststrategy: "performance"
            - name: "evaluation"
            - name: "release"

```

TO DO DESCRIPTION


## Onboard service
Duration: 3:00

After creating the project, services can be onboarded to our project.

1. Onboard the **helloservice** service using the [keptn onboard service](https://keptn.sh/docs/0.8.x/reference/cli/commands/keptn_onboard_service/) command:

    <!-- command -->
    ```
    keptn onboard service helloservice --project=litmus --chart=./helloservice/helm
    ```

1. After onboarding the service, tests need to be added as basis for quality gates in the different stages:
    <!-- command -->
    ```
    keptn add-resource --project=litmus --stage=chaos --service=helloservice --resource=helloservice/jmeter/load.jmx --resourceUri=jmeter/load.jmx
    keptn add-resource --project=litmus --stage=chaos --service=helloservice --resource=helloservice/jmeter/jmeter.conf.yaml --resourceUri=jmeter/jmeter.conf.yaml
    ```

## Configure Quality Gate
Duration: 3:00

1. We are  going to add the SLO-based quality gate

    ```
    keptn add-resource --project=litmus --stage=chaos --service=helloservice --resource=helloservice/prometheus/sli.yaml --resourceUri=prometheus/sli.yaml
    ```

1. 
    ```
    keptn add-resource --project=litmus --stage=chaos --service=helloservice --resource=helloservice/slo.yaml --resourceUri=slo.yaml
    ```


## Adding Litmus Chaos Experiment to Keptn
Duration: 2:00

1. adding...

    ```
    keptn add-resource --project=litmus --stage=chaos --service=helloservice --resource=helloservice/litmus/experiment.yaml --resourceUri=litmus/experiment.yaml
    ```


## Configure Prometheus
Duration: 3:00


    ```
    keptn configure monitoring prometheus --project=litmus --service=helloservice
    ```

    ```
    kubectl apply -f helloservice/prometheus/blackbox-exporter.yaml
    kubectl apply -f helloservice/prometheus/prometheus-server-conf-cm.yaml -n monitoring
    ```

1. Finally, restart Prometheus to pick up the new configuration
    
    ```
    kubectl delete pod -l app=prometheus-server -n monitoring
    ```


## Run experiment
Duration: 3:00

1. Let us now trigger the deployment, tests, and evaluation of our demo application.

    ```
    keptn trigger delivery --project=litmus --service=helloservice --image=jetzlstorfer/hello-server:v0.1.1
    ```

1. We can see that the evaluation failed, but why is that?

![](./assets/keptn-litmus/litmus-first-run.png)

1. Lets take a look at the evalution.

TO DO IMAGE

## Increase resilience
Duration: 3:00

1. Let's do another run of our deployment, tests, and evaluation. But this time, we are increasing the `replicaCount` meaning that we run 3 instances of our application. If one of those get deleted by Litmus, the two others should still be able to serve the traffic.
This time we are using the `keptn send event` command with an event payload that has been already prepared for the demo.

    ```
    keptn send event -f helloservice/deploy-event.json
    ```

![](./assets/keptn-litmus/litmus-second-run.png)


## Finish
Duration: 1:00

TODO

### What we've covered
TODO

{{ snippets/08/integrations/gettingStarted.md }}

{{ snippets/08/community/feedback.md }}
