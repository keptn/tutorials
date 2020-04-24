summary: Create a Keptn Notification Service
id: keptn-notification-service
categories: php,integration
tags: keptn06x
status: Draft
authors: Adam Gardner
Feedback Link: https://github.com/keptn/tutorials/tree/master/site/tutorials

# Create a Custom Notification Service

## Welcome
Duration: 00:01:00

This tutorial is a hands-on guide which will demonstrate how to write a custom Keptn "notification" service.

If you'd rather follow the official documentation, it's [here](https://tutorials.keptn.sh/?cat=installation). If you prefer a Go-based example, my colleague Christian Kreuzberger gave a [video walkthrough on Youtube](https://www.youtube.com/watch?v=42762GuB6C0).

## Prerequisites
Duration: 00:01:00

- A Keptn installation (full installation or quality gates only)
- A Docker Hub account
- Docker installed (and authenticated to DockerHub) on your local machine

## Notification Service Workflow
Duration: 00:02:00

Keptn "notification" services are standard services, they're known as "notification" services because they only listen and react to events.
They do not influence Keptn's workflow in any way.

Keptn services can be written in any language you choose.

A "notification" service workflow is something like this:

1. A distributor listens for a particular event
2. The distributor forwards the event to the subscribing service on a provided port
3. The custom service ingests the event
4. The custom service performs some logic (that you code)

## Create Keptn Distributor
Duration: 00:02:00

Every Keptn service requires a corresponding distributor. A distributor is a component which subscribes to Keptn events and forwards them your service. Think of a distributor as the "glue" between the Keptn core engine and your service.

Save the following content as a file called `demo-service-distributor.yaml`:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-service-distributor
  namespace: keptn
spec:
  selector:
    matchLabels:
      run: distributor
  replicas: 1
  template:
    metadata:
      labels:
        run: distributor
    spec:
      containers:
      - name: distributor
        image: keptn/distributor:0.6.1
        ports:
        - containerPort: 8080
        resources:
          requests:
            memory: "32Mi"
            cpu: "50m"
          limits:
            memory: "128Mi"
            cpu: "500m"
        env:
        - name: PUBSUB_URL
          value: 'nats://keptn-nats-cluster'
        - name: PUBSUB_TOPIC
          value: 'sh.keptn.internal.event.project.create'
        - name: PUBSUB_RECIPIENT
          value: 'demo-service'
        - name: PUBSUB_RECIPIENT_PORT
          value: '80'
```

The important parts are the environment variables at the bottom.

Read as: "This distributor is subscribing to the `sh.keptn.internal.event.project.create` event and will forward the event to the `demo-service` on port `80`.

Apply this file: `kubectl apply -f demo-service-distributor.yaml`

Verify that the distributor pod is running: `kubectl get pods -n keptn | grep demo`

```
demo-service-distributor-*-*   1/1   Running   0  39s
```

## Create Dockerfile
Duration: 00:02:00

The custom service we're creating will be built on an Apache webserver running PHP which listens on port `80`.

Notice that you decide what language your service is written in. As long as the service can accept an incoming HTTP request, you're free to implement in any language you choose.

Create a new `Dockerfile` with the following content:
```
FROM php:apache

COPY index.php /var/www/html/index.php
RUN chown -R www-data:www-data /var/www

CMD ["apache2-foreground"]
```

## Create index.php
Duration: 00:02:00

In the same folder as your `Dockerfile` create another file called `index.php`:
```
<?php

/* Create and open the log file
 * Root directory is /var/www/html/
 * So this log file is: /var/www/html/demoService.log
 */
$logFile = fopen("demoService.log", "a") or die("Unable to open file!");

// Get the incoming data from Keptn
$entityBody = file_get_contents('php://input');

// Decode the incoming JSON event
$cloudEvent = json_decode($entityBody);

/* Your logic here...
 * Write a log file entry into the /var/www/html/demoService.log
 */
fwrite($logFile,"Project Created: " . $cloudEvent->{'data'}->{'project'} . "\n\n");

// Close handle to log file
fclose($logFile);
?>
```

Whenever the distributor detects an `sh.keptn.internal.event.project.create` event, it passes the event to this custom service.

This service will parse the incoming keptn event then write a log line. This log file is stored at `/var/www/html/demoService.log` inside the `demo-service` pod.

The log line will look like this:
```
Project Created: <project-name>
```

## Build and Push Image
Duration: 00:02:00

Build and push your custom service to DockerHub. Be sure to substitute your Docker ID into the following command:

```
docker build -t <your-docker-username>/keptn-demo-service:notification . && docker push <your-docker-username>/keptn-demo-service:notification
```

## Deploy Your Keptn Service
Duration: 00:05:00

Create a file called `demo-service.yaml`.

Be sure to substitute **your** docker ID into the `image:` line

```
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo-service
  namespace: keptn
spec:
  selector:
    matchLabels:
      run: demo-service
  replicas: 1
  template:
    metadata:
      labels:
        run: demo-service
    spec:
      containers:
      - name: demo-service
        image: <your-docker-username>/keptn-demo-service:notification
        imagePullPolicy: Always
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: demo-service
  namespace: keptn
  labels:
    run: demo-service
spec:
  ports:
  - port: 80
    protocol: TCP
  selector:
    run: demo-service
```

Apply this file:
```
kubectl apply -f demo-service.yaml
```

Verify that both the `service` and `distributor` pods are running:

```
kubectl get pods -n keptn | grep demo

demo-service-*-*                1/1     Running   0   24s
demo-service-distributor-*-*    1/1     Running   0   39s
```

## Create Keptn Project
Duration: 00:02:00

Your custom service is now implemented and running. You're now ready to test the custom service.

Every Keptn project requires a shipyard file. This defines the structure of the project.

Create a basic single stage `shipyard.yaml` file:

```
stages:
  - name: "quality"
```

Create a project then check the `demo-service` container log `demoService.log`. The creation of the project should be logged to this file.

Create the project:
```
keptn create project demo-project --shipyard=shipyard.yaml
```

You should see the following output:
```
Starting to create project
ID of Keptn context: ***
Project demo-project created
Stage quality created
Shipyard successfully processed
```

Retrieve the `demo-service` pod name:
```
kubectl get pods -n keptn | grep demo
```

Substitute your pod name into the following command and execute:
```
kubectl exec -n keptn <your-pod> -- cat /var/www/html/demoService.log
```

You should see:
```
Project Created: demo-project
```

## Conclusion
Duration: 00:02:00

Congratulations. You've built a custom Keptn service which listens for an event and reacts to that event.

Now that you understand the basics, go forth and integrate with any other third-party tooling!