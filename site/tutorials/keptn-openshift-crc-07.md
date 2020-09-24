summary: Keptn on OpenShift with Code Ready Containers
id: keptn-openshift-crc-07
categories: openshift,full-tour,quality-gates,automated-operations
tags: keptn07x
status: Published 
authors: Marc Chisinevski, Jürgen Etzlstorfer
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials


# Keptn on OpenShift with Code Ready Containers

## Welcome
Duration: 2:00 

In this tutorial you'll get a full tour on how to run Keptn on Code Ready Containers. 
[Code Ready Containers](https://developers.redhat.com/products/codeready-containers/overview) gets you up and running with an OpenShift cluster on your local machine in minutes.

## Prerequisites
Duration: 5:00

1. Download the resources for this tutorial.
  ```
  git clone --branch release-0.1.0 https://github.com/keptn-sandbox/openshift-crc-tutorial

  cd openshift-crc-tutorial/resources
  ```


For running [Code Ready Containers](https://developers.redhat.com/products/codeready-containers/overview) a machine with at least 16 GB of RAM is recommended.

1. Download CRC from this website: https://developers.redhat.com/products/codeready-containers/download

1. Download CodeReady Containers in the current folder. There are versions available for Mac OS, Linux, and Windows. This tutorial has been tested on version TODO and the instructions here are for the Mac/Linux version.

1. Copy your pull secret to the current folder in a file called `pull-secret.txt`.

## Install CodeReady Containers
Duration: 10:00

1. Define the CodeReady Container version and your operating system - please adjust those variables to fit your environment!

  ```
  export OS=macos
  export CRCVERSION=1.14.0
  ```

  For Linus that might look like this.

  ```
  export OS=linux
  export CRCVERSION=1.14.0
  ```

1. Edit `crc.sh` if you want to configure the memory and CPU cores available to CodeReady Containers.

1. Execute the setup script
  ```
  ./crc.sh
  ```

1. Once finished, the script will provide you with some output:

  ```
  This will install OpenShift 4.5, display the login info and open a browser window with the OpenShift console.
  INFO To access the cluster, first set up your environment by following 'crc oc-env' instructions
  INFO Then you can access it by running 'oc login -u developer -p developer https://api.crc.testing:6443'
  INFO To login as an admin, run 'oc login -u kubeadmin -p yourpassword https://api.crc.testing:6443'
  INFO
  INFO You can now run 'crc console' and use these credentials to access the OpenShift web console
  Started the OpenShift cluster
  WARN The cluster might report a degraded or error state. This is expected since several operators have been disabled to lower the resource usage. For more information, please consult the documentation
  Opening the OpenShift Web Console in the default browser...
  ```

1. From the previous output, we still need to execute some commands. To access the cluster, first set up your environment by following 'crc oc-env' instructions.

  ```
  crc oc-env
  eval $(crc oc-env)
  ```

1. Login as an `admin` with the command that from the log output above. Please make sure to use the correct password that you see on your own screen.

  ```
  oc login -u kubeadmin -p yourpassword https://api.crc.testing:6443
  ```

Negative
: Depending on your machine, it might take a while (3-5 minutes) for CRC to ready and accept your login request. Please be patient. 

If you want to run it on a different environment than you local machine, check out these additional resources.

Negative
: Please note that the Keptn team is not the author of these resources. If you run into any issues please reach out to the original authors.

- https://kxr.me/2019/08/17/openshift-4-upi-install-libvirt-kvm/
- https://fedoramagazine.org/codeready-containers-complex-solutions-on-openshift-fedora/
- If you want to run it on a VM in GCP, please make sure nested virtualization is enabled. [Follow this official guide](https://cloud.google.com/compute/docs/instances/enable-nested-virtualization-vm-instances) if not yet enabled.


## Install OpenShift service mesh
Duration: 5:00

The script that is provided will create the following resources:

- Install Kiali, Jaeger and Service Mesh Operators
-  Deploy the Service Mesh control plane in istio-system.
- Create the Service Mesh member roll.

1. Execute the script:

```
./mesh.sh 
```

1. Verify that all pod in the `istio-namespace` are running (might take a while).

  ```
  oc get pods
  ```
  Shoud give you a similar result:
  ```
  NAME                                      READY   STATUS    RESTARTS   AGE
  grafana-6787dc695-b9srg                   2/2     Running   0          56s
  istio-citadel-6f9b74b754-2npp9            1/1     Running   0          3m43s
  istio-egressgateway-64ffbdb8c8-kbqbl      1/1     Running   0          91s
  istio-galley-7c6fb78655-ntbd2             1/1     Running   0          2m31s
  istio-ingressgateway-6c77fdbbd4-hxtch     1/1     Running   0          90s
  istio-pilot-7bf87fc66c-h5kmd              2/2     Running   0          109s
  istio-policy-55b9c86c8c-24szc             2/2     Running   0          2m16s
  istio-sidecar-injector-66fd9459d9-2qk5s   1/1     Running   0          83s
  istio-telemetry-859854d88b-2p9tb          2/2     Running   0          2m15s
  jaeger-64d858c8c5-44cfj                   2/2     Running   0          2m30s
  prometheus-6864b4b755-tk7q2               2/2     Running   0          3m24s
  ```

## Install Keptn

Let us know install Keptn on our local OpenShift cluster.

1. Download the Keptn CLI:
  ```
  curl -sL https://get.keptn.sh | sudo -E bash
  ```
1. Install Keptn into the cluster via the CLI:

  ```
  keptn install --use-case=continuous-delivery --platform=openshift
  ```

1. TODO verify if new resource limits are required

1. Expose the API endpoint of Keptn to be able to connect to it.

  ```
  oc expose svc api-gateway-nginx
  ``` 

1. Now let's connect the Keptn CLI to the Keptn installation.

  ```
  export KEPTN_ENDPOINT=http://api-gateway-nginx-keptn.apps-crc.testing/api
  export KEPTN_API_TOKEN=$(oc get secret keptn-api-token -n keptn -ojsonpath={.data.keptn-api-token} | base64 --decode)
  
  keptn auth --endpoint=$KEPTN_ENDPOINT --api-token=$KEPTN_API_TOKEN
  ```

## Deploy 


{{ snippets/07/community/feedback.md }}
