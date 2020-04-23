
## Open Keptn's bridge
Duration: 1:00

Now that you have installed Keptn you can take a look at its user interace aka the Keptn's Bridge.

Expose the bridge via the following command to be able to access on localhost:

```
kubectl port-forward svc/bridge -n keptn 9000:8080
```

Open a browser and navigate to http://localhost:9000 to take look. The bridge will be empty at this point but when using Keptn it will be populated with events.

![empty bridge](./assets/empty-bridge.png)

Positive
: We are frequently providing early access versions of the Keptn's Bridge with new functionality - [learn more here](https://keptn.sh/docs/0.6.0/reference/keptnsbridge/#early-access-version-of-keptn-s-bridge)!