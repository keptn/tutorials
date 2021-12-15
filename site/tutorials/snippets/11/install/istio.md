
## Install Istio
Duration: 10:00

Download the Istio command line tool by [following the official instructions](https://istio.io/latest/docs/setup/install/) or by executing the following steps.

<!-- command -->
```
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.12.1 sh -
```

Check the version of Istio that has been downloaded and execute the installer from the corresponding folder, e.g.:


<!-- command -->

```
./istio-1.11.2/bin/istioctl install
```

The installation of Istio should be finished within a couple of minutes.

```
This will install the Istio default profile with ["Istio core" "Istiod" "Ingress gateways"] components into the cluster. Proceed? (y/N) y
✔ Istio core installed
✔ Istiod installed
✔ Ingress gateways installed
✔ Installation complete
```