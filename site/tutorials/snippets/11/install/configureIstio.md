## Configure Istio

We are using Istio for traffic routing and as an ingress to our cluster. To make the setup experience as smooth as possible we have provided some scripts for your convenience. If you want to run the Istio configuration yourself step by step, please [take a look at the Keptn documentation](https://keptn.sh/docs/0.11.x/operate/install/#option-3-expose-keptn-via-an-ingress). 

The first step for our configuration automation for Istio is downloading the configuration bash script from Github:

<!-- command -->
```
curl -o configure-istio.sh https://raw.githubusercontent.com/keptn/examples/0.11.0/istio-configuration/configure-istio.sh
```

After that you need to make the file executable using the `chmod` command.

<!-- command -->
```
chmod +x configure-istio.sh
```

Finally, let's run the configuration script to automatically create your Ingress resources.

<!-- command -->
```
./configure-istio.sh
```

### What is actually created

Positive
: There is no need to copy the following resources, they are for information purposes only.

With this script, you have created an Ingress based on the following manifest.

```
---
apiVersion: networking.k8s.io/v1
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
      - path: /
        pathType: Prefix
        backend:
          service:
            name: api-gateway-nginx
            port:
              number: 80
```

Please be aware, when using OpenShift 3.11, instead using the above manifest, use the following one, as it uses an already deprecated apiVersion.

```
---
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

In addition, the script has created a gateway resource for you so that the onboarded services are also available publicly.

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

Finally, the script restarts the `helm-service` pod of Keptn to fetch this new configuration.
