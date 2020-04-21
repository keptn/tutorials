
## Install Keptn Quality Gate
Duration: 5:00

If you want to install Keptn just to explore the capabilities of quality gates, you have the option to roll-out Keptn **without** components for automated delivery and operations. Therefore, set the `use-case` flag to `quality-gates` when executing the [install](https://keptn.sh/docs/0.6.0/reference/cli/#keptn-install) command:

```
keptn install --platform=[aks|eks|gke|pks|openshift|kubernetes] --use-case=quality-gates
```
