
## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Linux or MacOS (preferred as some instructions are targeted for this platforms)
- On Windows: [Git Bash 4 Windows](https://gitforwindows.org/), [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)

## Configure OpenShift cluster
Duration: 10:00

Negative
: Please note that you have to bring your own OpenShift cluster in version 3.11


1. Install local tools if not already present on your machine.

  - [oc CLI - v3.11](https://github.com/openshift/origin/releases/tag/v3.11.0)

1. Make sure you are connected with your `oc` CLI to your OpenShift cluster.

1. On the OpenShift master node, execute the following steps:

- Set up the required permissions for your user:

    ```
    oc adm policy --as system:admin add-cluster-role-to-user cluster-admin <OPENSHIFT_USER_NAME>
    ```

- Set up the required permissions for the installer pod:

    ```
    oc adm policy  add-cluster-role-to-user cluster-admin system:serviceaccount:default:default
    oc adm policy  add-cluster-role-to-user cluster-admin system:serviceaccount:kube-system:default
    ```

- Enable admission WebHooks on your OpenShift master node:

    ```
    sudo -i
    cp -n /etc/origin/master/master-config.yaml /etc/origin/master/master-config.yaml.backup
    oc ex config patch /etc/origin/master/master-config.yaml --type=merge -p '{
    "admissionConfig": {
        "pluginConfig": {
        "ValidatingAdmissionWebhook": {
            "configuration": {
            "apiVersion": "apiserver.config.k8s.io/v1alpha1",
            "kind": "WebhookAdmission",
            "kubeConfigFile": "/dev/null"
            }
        },
        "MutatingAdmissionWebhook": {
            "configuration": {
            "apiVersion": "apiserver.config.k8s.io/v1alpha1",
            "kind": "WebhookAdmission",
            "kubeConfigFile": "/dev/null"
            }
        }
        }
    }
    }' >/etc/origin/master/master-config.yaml.patched
    if [ $? == 0 ]; then
    mv -f /etc/origin/master/master-config.yaml.patched /etc/origin/master/master-config.yaml
    /usr/local/bin/master-restart api && /usr/local/bin/master-restart controllers
    else
    exit
    fi
    ```
    
Find a full compatibility matrix for supported Kubernetes versions [here](https://keptn.sh/docs/0.8.x/operate/k8s_support/).