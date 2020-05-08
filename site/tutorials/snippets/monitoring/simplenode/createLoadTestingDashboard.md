## Create Load Testing Dashboard
Duration: 2:00

While it is great that Keptn pulls in all these metrics automatically for us and evaluates them as part of the quality gate - some of us might still want to look at a dashboard - seeing all metrics in real-time while tests are running. Or maybe going back in time and explore the details of a test that ran in the past.
Dynatrace provides an automation API to create dashboards, allowing us to create a dashboard that shows all key metrics of our application in a single view.

Make sure you navigate to the folder *examples\simplenodeservice\dynatrace*. Now execute this
```
$ ./createLoadTestingDashboard.sh
```

This script will create a new dashboard in Dynatrace called "Keptn Performance as a Self-Service Insights Dashboard". Go to Dynatrace, click on Dashboards and open it up. It should look somewhat like this!

![](./assets/simplenode/loadtestingdashboard.png)