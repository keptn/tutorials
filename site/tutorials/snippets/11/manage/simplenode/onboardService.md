
## Create a microservice for our project
Duration: 2:00

After creating the project, services can be created for our project.

1. Create the **simplenode** service using the [keptn create service](https://keptn.sh/docs/0.10.x/reference/cli/commands/keptn_create_service/) and [keptn add-resource](https://keptn.sh/docs/0.10.x/reference/cli/commands/keptn_add-resource/)commands:

```
keptn create service simplenode --project=simplenodeproject
keptn add-resource --project=simplenodeproject --service=simplenode --all-stages --resource=./carts.tgz --resourceUri=helm/simplenode.tgz
```

We have passed a helm charts directory to create a service. Keptn will use this Helm Chart for its delivery. It will also automatically create the respective deployments for our blue/green and direct deployment strategies in staging and prod. There is nothing we have to worry about


## Deploy first build with Keptn 
Duration: 2:00

After creating our service we can immediately start using Keptn to deploy an artifact.

1. Lets deploy version 1 of our simplenode service by executing the [keptn send event new-artifact](https://keptn.sh/docs/0.10.x/reference/cli/#keptn-send-event-new-artifact) command:

```
keptn send event new-artifact --project=simplenodeproject --service=simplenode --image=grabnerandi/simplenodeservice --tag=1.0.0
```

Keptn will now start deploying version 1.0.0 into staging. During the first deployment some special initial steps are performed, e.g: namespaces get created for each stage.
But - as we haven't yet uploaded tests and not specified SLI/SLOs for the Quality Gates Keptn will skip these checks and promote the artifact rather quickly into production. Overall that process should not take longer than 2-3 minutes

1. **Optional:** Verify the pods that should have been created for services carts and carts-db:

```
kubectl get pods --all-namespaces | grep simplenode
```

```
simplenodeproject-prod    simplenode-54d9b6775-4hlwn     1/1     Running     0          12m
simplenodeproject-staging simplenode-54d9b6775-rm8rw     1/1     Running     0          12m
```
