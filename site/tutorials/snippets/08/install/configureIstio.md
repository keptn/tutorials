## Configure Istio and Keptn

We are using Istio for traffic routing and as an ingress to our cluster. To make the setup experience as smooth as possible we have provided some scripts for your convenience. If you want to run the Istio configuration yourself step by step, please [take a look at the Keptn documentation](https://keptn.sh/docs/0.8.x/operate/install/#option-3-expose-keptn-via-an-ingress). 

The first step for our configuration automation for Istio is downloading the configuration bash script from Github:

<!-- command -->
```
curl -o configure-istio.sh https://raw.githubusercontent.com/keptn/examples/release-0.8.0-alpha/istio-configuration/configure-istio.sh
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
: There is no need to copy the following resources, there are for information purposes only.

With this script, you have created an Ingress based on the following manifest.

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

Besides, the script has created a gateway resource for you so that the onboarded services are also available publicly.

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

Besides, the `helm-service` pod of Keptn is restarted to fetch this new configuration.
