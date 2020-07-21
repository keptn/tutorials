
## Configure Keptn and activate the quality gate
Duration: 5:00


Let us create a Keptn project (e.g., *sockshop*) with only one the *hardening* stage declared in the `shipyard-quality-gates.yaml` file that we have cloned from the examples Github repository earlier. Please note that [defining a Git upstream](https://keptn.sh/docs/0.6.0/manage/project/#select-git-based-upstream) is recommended, but in case that is not wanted the parameters `git-user`, `git-token` and `git-remote-url` can be omitted.

```
keptn create project sockshop --shipyard=shipyard-quality-gates.yaml --git-user=GIT_USER --git-token=GIT_TOKEN --git-remote-url=GIT_REMOTE_URL
```

Create a Keptn service for your service (e.g., *carts*) you want to evaluate:

```
keptn create service carts --project=sockshop
```

Positive
: Since you are not actively deploying a service in this tutorial, [keptn create service](https://keptn.sh/docs/0.6.0/reference/cli/#keptn-create-service) does not require you to provide a Helm chart compared to the [keptn onboard service](https://keptn.sh/docs/0.6.0/reference/cli/#keptn-onboard-service) command. 

To activate the quality gate for your service, upload the `slo-quality-gates.yaml` file:

```
keptn add-resource --project=sockshop --stage=hardening --service=carts --resource=slo-quality-gates.yaml --resourceUri=slo.yaml
```

Let us take a look at the actual file we have just added:

```
---
spec_version: "0.1.1"
comparison:
  aggregate_function: "avg"
  compare_with: "single_result"
  include_result_with_score: "pass"
  number_of_comparison_results: 1
filter:
objectives:
  - sli: "response_time_p95"
    key_sli: false
    pass:             # pass if (relative change <= 10% AND absolute value is < 600ms)
      - criteria:
          - "<=+10%"  # relative values require a prefixed sign (plus or minus)
          - "<600"    # absolute values only require a logical operator
    warning:          # if the response time is below 800ms, the result should be a warning
      - criteria:
          - "<=800"
    weight: 1
total_score:
  pass: "90%"
  warning: "75%"
```

The activated quality gate is passed when the absolute value of the response time is below 600ms and the relative change of the response time compared to the previous evaluation is below 10%. The quality gate raises a warning when the absolute value of the response time is below 800ms.


Negative
: Please note that deployment and testing of your service is outside of the scope of this tutorial. You would typically do this as part of your CI/CD pipeline.
