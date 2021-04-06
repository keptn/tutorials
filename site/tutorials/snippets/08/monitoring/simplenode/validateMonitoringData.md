
## Validate Dynatrace Monitoring Data
Duration: 2:00

Once Keptn has deployed our application and we have successfully validated that the app is indeed running by accessing the app through its URL we can also validate that Dynatrace is monitoring not only your k8s cluster but also the app we have deployed.

In Dynatrace use the navigation menu on the left and navigate to the Host view. You should find an entry for each of your k8s cluster nodes. Click one of them. You should see host metrics, list of processes & containers, events ...
Via the `...` button you can access the Smartscape view which gives you full stack visibility of everything that is hosted on that k8s cluster node. You should also see our deployed Node.js services which you can click on and navigate to the detailed view:

![](./assets/simplenode/validatemonitoring.png)

If you navigate to the service view you will notice that the service has 4 tags on it: keptn_project, keptn_stage, keptn_service and keptn_deployment. These tags are extracted from the Helm Chart which is passing this information via DT_CUSTOM_PROP. These tags also later allow Keptn to query data exactly for a specific deployed service, e.g: only data from our service deployed in staging!