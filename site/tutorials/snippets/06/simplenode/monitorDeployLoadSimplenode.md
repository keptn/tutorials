
## Monitor, Deploy and Run Load against Simplenode
Duration: 5:00

In our tutorial we are not using Keptn for deploying our application. The goal is to show you that Keptn can also be used for Quality Gates or even Performance Evaluation on applications deployed manually or through other deployment automation tools.

We do however need an application that is monitored by Dynatrace in order for Keptn to pull out metrics during the evaluation. 

In case you do not have your own application and the tutorial offered you to deploy this simple node.js-based sample application then follow these steps to deploy it and get it monitored by Dynatrace.

### Host monitored with Dynatrace

Before we deploy our application lets make sure that your host is monitored with Dynatrace. To accomplish that make sure that you install the [Dynatrace OneAgent](https://www.dynatrace.com/support/help/setup-and-configuration/dynatrace-oneagent/) on your host where you will be deploying our application later on. One option is to standup a virtual machine on your favorite cloud vendor. and either add the installation instructions of the OneAgent to the startup script or execute it once the machine is running. The end goal should be that Dynatrace is monitoring that host:

![](./assets/dynatrace_qualitygates/oneagentonlinuxhost.png)

Another option would be to deploy that application on a Kubernetes cluster. In that case please follow the instructions to [deploy the Dynatrace OneAgent on Kubernetes](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/)

### Deploy the sample app

Now as we have Dynatrace monitor your host we can deploy our container. Here is the example on how to deploy it using docker:
```
docker run -p 80:8080 grabnerandi/simplenodeservice:1.0.0
```
This will deploy Build 1.0.0 of the simplenodeservice sample application and exposing it via port 80. If you have your firewalls setup correctly you should be able to navigate to the website as well as shortly after seeing the SimpleNodeJsService show up in Dynatrace:
![](./assets/dynatrace_qualitygates/simplenodeservice_afterlaunch.png)


### Put some load on it

Last what we need is some consistent load on the service so that later on when asking Keptn to evaluate SLIs against our SLOs Dynatrace has data for that time period.
The examples repository from Git that you have cloned locally contains two options
1: Running JMeter
If you happen to have JMeter installed you can run the load.jmx script (from examples/simplenodeservice/keptn/jmeter). Before you do please change the SERVER_URL variable to the URL of your hosted version of the simplenode application. Additionally you should also change the ThreadGroups Loop Count setting to forever so that the test keeps running!

2: Run a batch with CURL
Another option is to launch the gen_load.sh file you will find under examples/simplenodeservice/helpers. This script uses curl to execute some simple GET requests. It will run until you either kill the process or until the script finds the file endloadtest.txt (which can be empty).

To validate if load comes through navigate to the service in Dynatrace and validate that you see performance & trace data for your monitored service!