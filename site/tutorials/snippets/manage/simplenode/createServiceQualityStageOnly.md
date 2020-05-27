
## Add our microservice to our project
Duration: 2:00

After creating a Keptn project, services can be added. If we want to use Keptn for Progressive Delivery where Keptn deploys our service using Helm we can use `keptn onboard service`. In the case where Keptn doesn't do the deployment but is used for Quality Gate or Performance Evaluation we use the command [keptn create service](https://keptn.sh/docs/0.6.0/reference/cli/commands/keptn_create_service/):

```
keptn create service evalservice --project=qgproject
```

This command just created a service we call *evalservice* and we added it to our *qgproject*

We can validate that this service was added by opening up Keptn's bridge and navigate to the *qgproject*. 