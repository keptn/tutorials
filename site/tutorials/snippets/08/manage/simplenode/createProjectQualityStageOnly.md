## Create a Keptn Quality Gate Project
Duration: 2:00

A project in Keptn is the logical unit that can hold multiple (micro)services. Therefore, it is the starting point for each Keptn installation.

To get all files you need for this tutorial, please clone the example repo to your local machine.
```
git clone --branch release-0.8.0 https://github.com/keptn/examples.git --single-branch

cd examples/simplenodeservicequality-gate-only
```

For this quality gate focused tutorial we will create a new Keptn project using `keptn create project` to create a project called *qgproject* using the shipyard_qualitystageonly.yaml as a shipyard definition. 
Before executing the following command, make sure you are in the `examples/simplenodeservicequality-gate-only` folder.
Please note that [defining a Git upstream](https://keptn.sh/docs/0.8.x/manage/project/#select-git-based-upstream) is recommended, but in case that is not wanted the parameters `git-user`, `git-token` and `git-remote-url` can be omitted.

```
keptn create project qgproject --shipyard=./shipyard_qualitystageonly.yaml --git-user=GIT_USER --git-token=GIT_TOKEN --git-remote-url=GIT_REMOTE_URL
```

For our purpose we create a simple project with a single stage called **qualitystage** as we only use Keptn for quality gate evaluations instead of using Keptn for multi-stage delivery pipelines. The content of this shipyard file is rather simple:

```
stages:
  - name: "qualitystage"
```

Later - as we onboard services - we will be able to use this qualitystage to let Keptn evaluate our SLI/SLO based quality gates!

Positive
: To learn more about a *shipyard* file, please take a look at the [Shipyard specification](https://github.com/keptn/spec/blob/master/shipyard.md).

