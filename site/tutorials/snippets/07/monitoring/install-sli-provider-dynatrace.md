## Setup SLI provider
Duration: 2:00

During the evaluation of a quality gate, the Dynatrace SLI provider is required that is implemented by an internal Keptn service, the dynatrace-sli-service. This service will fetch the values for the SLIs that are referenced in an SLO configuration.

<!-- command -->
```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-sli-service/0.5.0/deploy/service.yaml
```

Next we are going to add an SLI configuration file for Keptn to know how to retrieve the data.
Please make sure you are in the correct folder that is `examples/onboarding-carts`. If not, please change the directory accordingly, e.g., with `cd ../../onboarding-carts/`. We are going to add it globally to the project for all services and stages we create.

<!-- bash cd ../../onboarding-carts/ -->

<!-- command -->
```
keptn add-resource --project=sockshop --resource=sli-config-dynatrace.yaml --resourceUri=dynatrace/sli.yaml
```

Configure the already onboarded project with the new SLI provider for Keptn to create some needed resources (e.g., a configmap):

<!-- command -->
```
keptn configure monitoring dynatrace --project=sockshop
```

Positive
: Since we already installed the Dynatrace service, the SLI provider can fetch the credentials to connect to Dynatrace from the same secret we created earlier.
