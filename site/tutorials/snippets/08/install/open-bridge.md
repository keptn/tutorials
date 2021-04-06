
## Open Keptn's Bridge & API
Duration: 1:00

Now that you have installed Keptn you can take a look at its user interface aka the Keptn's Bridge.

### Keptn's Bridge

Open a browser and navigate to [http://localhost:8080](http://localhost:8080) to take look. The bridge will be empty at this point but when using Keptn it will be populated with events.

If asked for credentials, you can get them by executing the following command.
```
keptn configure bridge --output
```

![empty bridge](./assets/bridge-empty.png)

Positive
: We are frequently providing early access versions of the Keptn's Bridge with new functionality - [learn more here](https://keptn.sh/docs/0.8.x/reference/bridge/#early-access-version-of-keptn-bridge)!

### Keptn API

Besides the Keptn's Bridge, please consider also taking a look at the Keptn API endpoint if you are interested to interact with Keptn via the API. Keptn comes with a fully documented swagger-API that can be found under the `/api` endpoint.

![api](./assets/keptn-api.png)