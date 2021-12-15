summary: Explore Keptn on our hosted demo cluster - no installation needed.
id: keptn-public-demo-011
categories: prometheus,quality-gates,k3s
tags: keptn011x,introduction,quickstart
status: Published 
authors: Jürgen Etzlstorfer
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials



# Explore Keptn without installation

## Explore Keptn
Duration: 5:00

![https://www.youtube.com/watch?v=MqG8vw_bc8A](.)

 We are providing a hosted Keptn installation that you can explore without installing anything. Head over to [keptn.public.demo.keptn.sh](https://keptn.public.demo.keptn.sh/) and have a look around to explore 4 different projects that we are currently hosting:

### Access the demos via [keptn.public.demo.keptn.sh](https://keptn.public.demo.keptn.sh/)

Please find a short description of the projects to explore:

### 1. **Litmus**
Explore this project that orchestrates load tests along with chaos experiments to evaluate the resilience of applications. Learn more about this use case in the blog series ([part 1](https://medium.com/keptn/evaluating-kubernetes-resiliency-with-keptn-and-litmuschaos-66bdfb35cbdd?source=friends_link&sk=86b269ad3cec917ba1176328a20e914f), [part 2](https://medium.com/keptn/part-2-evaluating-application-resiliency-with-keptn-and-litmuschaos-use-case-and-demo-f43b264a2294?source=friends_link&sk=9a6810624fb5c85822c9e9484678722c)), in our [Keptn user group presentation](https://keptn.sh/resources/integrations/#evaluating-the-resiliency-of-your-microservices-with-litmuschaos-tests-and-keptn), and replicate this setup via our [tutorial](https://tutorials.keptn.sh/tutorials/keptn-litmus-11/index.html).

### 2. Podtatohead
Explore the 2-stage demo with the CNCF podtatohead application that has been onboarded. The application is deployed twice per day, with one fast and one slower build. Explore how the Keptn quality gates prevent the slower run to reach production, based on data from Prometheus. Please have a look at the [dedicated tutorial](https://tutorials.keptn.sh/tutorials/keptn-multistage-qualitygates-11/index.html) to set this up yourself.
### 3. Sockshop

Our famous Sockshop application with a 3-stage environment and quality gates using data from Dynatrace. Each day 3 builds try to make it into production, but only two versions are stable enough to pass the quality gates. You can set up this demo yourself by following the Sockshop tutorial using either [Prometheus](https://tutorials.keptn.sh/tutorials/keptn-full-tour-prometheus-11/index.html) or [Dynatrace](https://tutorials.keptn.sh/tutorials/keptn-full-tour-dynatrace-11/index.html).

### 4. Unleash
This project is holds the Unleash feature toggle framework that is used in our demos for auto-remediating production issues by switching feature flags. Learn more in our [full tours](https://tutorials.keptn.sh/tutorials/keptn-full-tour-dynatrace-11/index.html) how to set it up yourself.


### Your favorite project
What is your favorite project? Let us know via [Twitter](https://twitter.com/keptnProject) or in our [Slack channel](https://slack.keptn.sh).

{{ snippets/11/community/feedback.md }}
