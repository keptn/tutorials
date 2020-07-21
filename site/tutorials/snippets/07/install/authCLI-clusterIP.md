
## Authenticate Keptn CLI
Duration: 2:00

Expose the Keptn endpoint via the following command to be able to access on localhost:

```
kubectl -n keptn port-forward service/api-gateway-nginx 8080:80
```

Set the following variables to make it easy to connec to Keptn.

```
KEPTN_ENDPOINT=http://localhost:8080/api
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
```

To authenticate the CLI against the Keptn cluster, use the keptn auth command:

```
keptn auth --endpoint=$KEPTN_ENDPOINT --api-token=$KEPTN_API_TOKEN
```

```
Starting to authenticate
Successfully authenticated
```

Positive
: Congratulations! Your CLI is now successfully authenticated to your Keptn installation.

Positive
: Please note that the Keptn endpoint can also be pubicly exposed. All details can be found in the [Keptn docs](https://keptn.sh/docs/0.7.x/operate/install/).