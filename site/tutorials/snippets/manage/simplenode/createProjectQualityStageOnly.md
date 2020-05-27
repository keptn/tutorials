## Create a Keptn Quality Gate Project
Duration: 2:00

A project in Keptn is the logical unit that can hold multiple (micro)services. Therefore, it is the starting point for each Keptn installation.

To get all files you need for this tutorial, please clone the example repo to your local machine.
```
git clone --branch release-0.6.2 https://github.com/keptn/examples.git --single-branch

cd examples/simplenodeservicequality-gate-only
```

For this quality gate focused tutorial we will create a new Keptn project using `keptn create project` to create a project called *qgproject* using the shipyard_qualitystageonly.yaml as a shipyard definition. 
Before executing the following command, make sure you are in the `examples/simplenodeservicequality-gate-only` folder.

```
keptn create project qgproject --shipyard=./shipyard_qualitystageonly.yaml
```

For our purpose we create a simple project with a single stage called **qualitystage** as we only use Keptn for quality gate evaluations instead of using Keptn for multi-stage delivery pipelines. The content of this shipyard file is rather simple:

```
stages:
  - name: "qualitystage"
```

Later - as we onboard services - we will be able to use this qualitystage to let Keptn evaluate our SLI/SLO based quality gates!

Positive
: To learn more about a *shipyard* file, please take a look at the [Shipyard specification](https://github.com/keptn/spec/blob/master/shipyard.md).

