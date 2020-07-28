## Configure Istio and Keptn

Get the `EXTERNAL-IP` from the `istio-ingressgateway` as you will need it in the next step
```
kubectl -n istio-system get svc istio-ingressgateway
```
```
NAME                   TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)                                                      AGE
istio-ingressgateway   LoadBalancer   10.0.171.50   40.125.XXX.XXX   15021:30094/TCP,80:32076/TCP,443:31452/TCP,15443:31721/TCP   2m36s
```

In my case it is something like `40.125.XXX.XXX`.

Create a file `ingress-manifest.yaml` and copy the following content.
```
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: istio
  name: api-keptn-ingress
  namespace: keptn
spec:
  rules:
  - host: <IP-ADDRESS>.nip.io
    http:
      paths:
      - backend:
          serviceName: api-gateway-nginx
          servicePort: 80
```

Next, make sure to replace the `<IP-ADDRESS>` with the actual IP of the ingress gateway that you just copied. Please note that we are using [nip.io](https://nip.io/) (a wildcard DNS resolver) only for the purpose of this tutorial. In a production environment, you might want to use your own domain name here.

Now let's apply the manifest to the cluster.

```
kubectl apply -f ingress-manifest.yaml
```

Next, we will also need a Gateway for Keptn. Therefore copy and paste the following content into a file named `gateway.yaml` and apply it to your Kubernetes cluster.
```
---
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: public-gateway
  namespace: istio-system
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      name: http
      number: 80
      protocol: HTTP
    hosts:
    - '*'
```

```
kubectl apply -f gateway-manifest.yaml
```

Create a `ConfigMap` for Keptn to pick up with all the needed information. Therefore execute the following statement that will create the configmap.
```
kubectl create configmap -n keptn ingress-config --from-literal=ingress_hostname_suffix=$(kubectl -n keptn get ingress api-keptn-ingress -ojsonpath='{.spec.rules[0].host}') --from-literal=ingress_port=80 --from-literal=ingress_protocol=http --from-literal=istio_gateway=public-gateway.istio-system -oyaml --dry-run | kubectl replace -f -
```

Finally, restart the Helm service of Keptn to pick up the just created configuration.
```
kubectl delete pod -n keptn -lapp.kubernetes.io/name=helm-service
```
