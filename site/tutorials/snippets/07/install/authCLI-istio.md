## Connect your Keptn CLI to the Keptn installation

In this section we are referring to the Linux/MacOS derivates of the commands. If you are using a Windows host, please [follow the official instructions](https://keptn.sh/docs/0.7.0/operate/install/#5-authenticate-keptn-cli).

```
KEPTN_ENDPOINT=http://$(kubectl -n keptn get ingress api-keptn-ingress -ojsonpath={.spec.rules[0].host})/api
KEPTN_API_TOKEN=$(kubectl get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
```

Use this stored information and authenticate the CLI.
```
keptn auth --endpoint=$KEPTN_ENDPOINT --api-token=$KEPTN_API_TOKEN
```

That will give you:
```
Starting to authenticate
Successfully authenticated
```

Positive
: Congratulations - Keptn is successfully installed and your CLI is connected to your Keptn installation!

If you want, you can go ahead and take a look at the Keptn API by navigating to the endpoint that is given via
```
echo $KEPTN_ENDPOINT
```

![api](./assets/keptn-api.png)