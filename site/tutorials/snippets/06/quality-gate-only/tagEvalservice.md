## Tag service for quality gate evaluation
Duration: 2:00

Whether you are using our sample application or your own application, in order for the quality gate evaluation to work we need to properly tag the service. This is important as SLI (Service Level Indicators) will be queried from Dynatrace only from entities that match a certain tag. In our case it will add a tag that matches the name of of the Keptn Service which is *evalservice*. In Dynatrace there are multiple options to put a tag on a service:
* [Manual Tagging](https://www.dynatrace.com/support/help/how-to-use-dynatrace/tags-and-metadata/setup/how-to-define-tags/): put them on service and the process group via the UI or the Dynatrace API
* [Automated Tagging](https://www.dynatrace.com/support/help/how-to-use-dynatrace/tags-and-metadata/setup/how-to-define-tags/): define a rule that tag entities based on existing meta data
* Cloud & Platform Tags: extract tags & annotations from [k8s](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/other-deployments-and-configurations/leverage-tags-defined-in-kubernetes-deployments/), [OpenShift](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/openshift/other-deployments-and-configurations/leverage-tags-defined-in-openshift-deployments/) or [Cloud Foundry](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/cloud-foundry/other-deployments-and-configurations/leverage-tags-defined-in-cloud-foundry-deployments/)
* [Environment Tags](https://www.dynatrace.com/support/help/how-to-use-dynatrace/tags-and-metadata/setup/define-tags-based-on-environment-variables/): specify tags via the DT_TAGS environment variable

In our example we simply go the manual tagging route which means we simply add a tag called *evalservice* to the deployed service via the Dynatrace UI like shown below:
![](./assets/dynatrace_qualitygates/simplenodeservice_tagged.png)