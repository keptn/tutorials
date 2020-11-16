
## Create your first project
Duration: 5:00

A project in Keptn is the logical unit that can hold multiple (micro)services. Therefore, it is the starting point for each Keptn installation.

To get all files you need for this tutorial, please clone the example repo to your local machine.

<!-- command -->

```
git clone --branch release-0.7.3 https://github.com/keptn/examples.git --single-branch

cd examples/onboarding-carts
```


Create a new project for your services using the `keptn create project` command. In this example, the project is called *sockshop*. Before executing the following command, make sure you are in the `examples/onboarding-carts` folder.

**Recommended:** Create a new project with Git upstream:

To configure a Git upstream for this tutorial, the Git user (`--git-user`), an access token (`--git-token`), and the remote URL (`--git-remote-url`) are required. If a requirement is not met, go to [the Keptn documentation](https://keptn.sh/docs/0.7.0/manage/git_upstream/) where instructions for GitHub, GitLab, and Bitbucket are provided.

Let's define the variables before running the command:

<!-- bash keptn create project sockshop --shipyard=./shipyard.yaml -->

```
GIT_USER=gitusername
GIT_TOKEN=gittoken
GIT_REMOTE_URL=remoteurl
```

Now let's create the project using the `keptn create project` command.

```
keptn create project sockshop --shipyard=./shipyard.yaml --git-user=$GIT_USER --git-token=$GIT_TOKEN --git-remote-url=$GIT_REMOTE_URL
```


**Alternatively:** If you don't want to use a Git upstream, you can create a new project without it but please note that this is not the recommended way:

<!-- command -->
```
keptn create project sockshop --shipyard=./shipyard.yaml
```


For creating the project, the tutorial relies on a `shipyard.yaml` file as shown below:

```
stages:
  - name: "dev"
    deployment_strategy: "direct"
    test_strategy: "functional"
  - name: "staging"
    approval_strategy: 
      pass: "automatic"
      warning: "automatic"
    deployment_strategy: "blue_green_service"
    test_strategy: "performance"
  - name: "production"
    approval_strategy: 
      pass: "automatic"
      warning: "manual"
    deployment_strategy: "blue_green_service"
    remediation_strategy: "automated"
```


This shipyard contains three stages: dev, staging, and production. This results in the three Kubernetes namespaces: sockshop-dev, sockshop-staging, and sockshop-production.

* **dev** will have a direct (big bang) deployment strategy and functional tests are executed
* **staging** will have a blue/green deployment strategy with automated approvals for passing quality gates as well as quality gates which result in warnings. As configured, performance tests are executed.
* **production** will have a blue/green deployment strategy without any further testing. Approvals are done automatically for passed quality gates but manual approval is needed for quality gate evaluations that result in a warning. The configured remediation strategy is used for self-healing in production.


Positive
: To learn more about a *shipyard* file, please take a look at the [Shipyard specification](https://github.com/keptn/spec/blob/master/shipyard.md).

Let's take a look at the project that we have just created. We can find all this information in the Keptn's Bridge.
Therefore, we need the credentials that have been automatically generated for us.

<!-- command -->
```
keptn configure bridge --output
```

Now use these credentials to access it on your [Keptn's Bridge](echo http://api-gateway-nginx-keptn.apps-crc.testing/bridge).


You will find the just created project in the bridge with all stages.
![bridge](./assets/bridge-new.png)
![bridge](./assets/bridge-empty-env.png)
