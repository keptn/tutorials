## Setup SLI provider
Duration: 2:00

During the evaluation of a quality gate, the Dynatrace SLI provider is required that is implemented by an internal Keptn service, the dynatrace-sli-service. This service will fetch the values for the SLIs that are referenced in an SLO configuration.

```
kubectl apply -f https://raw.githubusercontent.com/keptn-contrib/dynatrace-sli-service/release-0.10.3/deploy/service.yaml -n keptn
```

Configure the already onboarded project with the new SLI provider:

```
keptn configure monitoring dynatrace --project=qgproject
```

Positive
: Since we already installed the Dynatrace service, the SLI provider can fetch the credentials to connect to Dynatrace from the same secret we created earlier.
