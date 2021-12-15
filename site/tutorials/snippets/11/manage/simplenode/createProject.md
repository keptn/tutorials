## Create a Keptn Project
Duration: 2:00

A project in Keptn is the logical unit that can hold multiple (micro)services. Therefore, it is the starting point for each Keptn installation.

To get all files you need for this tutorial, please clone the example repo to your local machine.
```
git clone --branch 0.11.0 https://github.com/keptn/examples.git --single-branch

cd examples/simplenodeservice
```

Create a new project for your services using the `keptn create project` command. In this example, the project is called *simplenodeproject*. Before executing the following command, make sure you are in the `examples/simplenodeservice/keptn` folder.
Please note that [defining a Git upstream](https://keptn.sh/docs/0.9.x/manage/project/#select-git-based-upstream) is recommended, but in case that is not wanted the parameters `git-user`, `git-token` and `git-remote-url` can be omitted.

```
keptn create project simplenodeproject --shipyard=./shipyard.yaml --git-user=GIT_USER --git-token=GIT_TOKEN --git-remote-url=GIT_REMOTE_URL
```

For creating the project, the tutorial relies on a `shipyard.yaml` file as shown below:

```
stages:
  - name: "staging"
    deployment_strategy: "direct"
    test_strategy: "performance"
  - name: "prod"
    deployment_strategy: "blue_green_service"
    test_strategy: "performance"
```

This shipyard contains two stages: staging, and prod. This results in the three Kubernetes namespaces: simplenodeproject-staging, and simplenodeproject-prod.

* **staging** will have a direct (big bang) deployment strategy and performance tests are executed. If tests are good and SLI/SLO based quality gates are passed Keptn will promote it to the *prod* stage
* **prod** will have a blue/green deployment strategy also using performance tests to validate that deployment and eventually switch between blue/green in case performance testing has revealed a problem

Positive
: To learn more about a *shipyard* file, please take a look at the [Shipyard specification](https://github.com/keptn/spec/blob/master/shipyard.md).

