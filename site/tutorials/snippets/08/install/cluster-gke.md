
## Prerequisites for installation
Duration: 5:00

Please download and install the following tools if you do not have them installed on your machine already.

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- Linux or MacOS (preferred as some instructions are targeted for this platforms)
- On Windows: [Git Bash 4 Windows](https://gitforwindows.org/), [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
- Alternative: [Google Cloud Shell](https://cloud.google.com/shell) (or alike)

## Setup Kubernetes cluster
Duration: 10:00

We are going to setup a Kubernetes cluster in the Google Cloud Platform.

1. Install local tools
  - [gcloud](https://cloud.google.com/sdk/gcloud/)

2. Create GKE cluster
  - Master version >= `1.15.x` (tested version: `1.15.9-gke.22`)
  - One **n1-standard-8** node. Please note that you might go for a smaller or larger size cluster depending on the concrete use case. The suggested sizing is based on the recommendation for the [full tour](../../?cat=full-tour) tutorials.
  - Image type `ubuntu` or `cos` (**Note:** If you plan to use Dynatrace monitoring, select `ubuntu` for a more [convenient setup](https://keptn.sh/docs/0.8.x/monitoring/dynatrace/install/#notes).)
  - Sample script to create such cluster:

    ```
    # set environment variables
    PROJECT=nameofgcloudproject
    CLUSTER_NAME=nameofcluster
    ZONE=us-central1-a
    REGION=us-central1
    GKE_VERSION="1.15"
    ```

    ```
    gcloud container clusters create $CLUSTER_NAME --project $PROJECT --zone $ZONE --no-enable-basic-auth --cluster-version $GKE_VERSION --machine-type "n1-standard-8" --image-type "UBUNTU" --disk-type "pd-standard" --disk-size "100" --metadata disable-legacy-endpoints=true --scopes "https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" --num-nodes "1" --enable-stackdriver-kubernetes --no-enable-ip-alias --network "projects/$PROJECT/global/networks/default" --subnetwork "projects/$PROJECT/regions/$REGION/subnetworks/default" --addons HorizontalPodAutoscaling,HttpLoadBalancing --no-enable-autoupgrade
    ```

Find a full compatibility matrix for supported Kubernetes versions [here](https://keptn.sh/docs/0.8.x/operate/k8s_support/).
