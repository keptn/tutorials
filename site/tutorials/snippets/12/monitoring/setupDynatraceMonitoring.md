## Set up Dynatrace monitoring
Once the *sockshop* project has been created, use the following command to configure the project to use Dynatrace for monitoring. This will also set up monitoring in your Dynatrace environment.

    <!-- command -->
    ```
    keptn configure monitoring dynatrace --project=sockshop
    ```

    The output of the command will tell you what has been set up in your Dynatrace environment:
    ```
    ID of Keptn context: 79f19c36-b718-4bb6-88d5-cb79f163289b
    Dynatrace monitoring setup done.
    The following entities have been configured:
    
    ...
    ---Problem Notification:--- 
      - Successfully set up Keptn Alerting Profile and Problem Notifications
    ...

    ```

**Verify Dynatrace configuration**

Since Keptn has configured your Dynatrace tenant, let us take a look what has be done for you:


- *Tagging rules:* When you navigate to **Settings > Tags > Automatically applied tags** in your Dynatrace tenant, you will find following tagging rules:
    - keptn_deployment
    - keptn_project
    - keptn_service
    - keptn_stage
  
    This means that Dynatrace will automatically apply tags to your onboarded services.

- *Problem notification:* A problem notification has been set up to inform Keptn of any problems with your services to allow auto-remediation. You can check the problem notification by navigating to **Settings > Integration > Problem notifications** and you will find a **keptn remediation** problem notification.

- *Alerting profile:* An alerting profile with all problems set to *0 minutes* (immediate) is created. You can review this profile by navigating to **Settings > Alerting > Alerting profiles**.

- *Dashboard and Management zone:* When creating a new Keptn project or executing the [keptn configure monitoring](https://keptn.sh/docs/0.12.x/reference/cli/commands/keptn_configure_monitoring/) command for a particular project (see Note 1), a dashboard and management zone will be generated reflecting the environment as specified in the shipyard file.
