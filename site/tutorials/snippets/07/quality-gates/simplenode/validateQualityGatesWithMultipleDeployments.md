## Run more builds - validate all quality gates 
Duration: 5:00

In the last steps we finished setting up tests and quality gates for both staging and production.
Now its time to put this to the test. If you remember - the samplenodeservice app comes with 4 different builds. Every build has a unique characteristic, e.g: some builds are good all the way to production, some builds have a high failure rate and should be stopped by the stagging quality gate, some builds are only problematic in production and should therefore be rolled back during a blue/green validation phase.

Here is what we are going to do in this step. We are going to deploy build 2, 3 and then 4 and validate if Keptn catches all problems as highlighted in the next image:
![](./assets/simplenode/simplenodeappoverview.png)

1. Let's deploy build 2.0.0

```
keptn send event new-artifact --project=simplenodeproject --service=simplenode --image=grabnerandi/simplenodeservice --tag=2.0.0
```

Watch the bridge and see if build 2.0.0 is stopped by the quality gate. It should - as build 2.0.0 has a high failure rate which is detected by the SLI error_rate!

2. Let's deploy build 3.0.0

```
keptn send event new-artifact --project=simplenodeproject --service=simplenode --image=grabnerandi/simplenodeservice --tag=3.0.0
```

Watch the bridge and see if build 3.0.0 makes it all the way to production and stays there. It should - as build 3.0.0 has no high failure rate any longer and also doesnt show any other signs of problems. As we have production quality gates enabled as well you should also see tests being executed in production followed by quality gate evaluation.

3. Let's deploy build 4.0.0

```
keptn send event new-artifact --project=simplenodeproject --service=simplenode --image=grabnerandi/simplenodeservice --tag=4.0.0
```

Watch the bridge and see if build 4.0.0 makes it all the way to production and is then rejected and rolled back to build 3.0.0. Build 4 should pass the quality gate in staging as the problem that is built into 4.0.0 only shows up in production. This is why you should see the build being promoted in production. But - after the tests are executed and evaluation fails Keptn will automatically roll it back to Build 3 in production. You can also validate this by browsing to your app

