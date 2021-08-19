[![Netlify Status](https://api.netlify.com/api/v1/badges/244ac853-f6f6-4005-a02a-ec7ba2a2b4e1/deploy-status)](https://app.netlify.com/sites/keptn-tutorials/deploys)

# How to write your own tutorial

To get a full setup of Google Codelabs you can follow this tutorial https://medium.com/@zarinlo/publish-technical-tutorials-in-google-codelab-format-b07ef76972cd. However, not everything is needed to get started.

## Tools needed if builder.sh is NOT used

- [claat](https://github.com/googlecodelabs/tools/tree/master/claat#install) (included in this repo for mac and linux, for windows please go ahead and download it)
- Optional: [gulp](https://gulpjs.com/)

For development:
- Go language
- Node.js v10+ and npm

## Write your tutorial

Thanks for considering contributing a tutorial or fixing a bug!

1. Fork the repo and clone it to your local machine.

1. Find all tutorial located in the `tutorials/site/tutorials` folder.

1. Start your tutorial by taking a look at the `tutorial-template.md` file in this folder. You can just duplicate the file and adopt it to get started easily. The contents of the file should be self-explanatory. Make sure to change the "ID" as this will be the folder the generated files of your new tutorial will be go into.

1. Write the tutorial - make sure you use some of the features that are described in the `tutorial-template.md` file such as `duration` information or highlights of some sections.


## Generate contents and test locally

1. Generate ONLY ONE tutorial and test it locally

    ```
    ./builder.sh my-tutorial.md

1. You can now start a local webserver take a look at your tutorial (you'll find the `claat` binary in the `./bin` folder, please copy it in your path)

    ```
    claat serve
    ```

1. Alternatively, generate ALL tutorials and test it locally.
    ```
    ./builder.sh 

    claat serve
    ```

  
### Optional: Preview overview site 

- To generate not only the local preview for the tutorials themselves but also the overview page of all tutorials, execute the following command and navigate to the URL that is given to you after executing the command (you need to install `gulp` first, take a look at the prerequisites):
    ```
    gulp serve 
    ```

- If you want to generate the content without starting the server for preview, execute the following command:
    ```
    gulp dist
    ```

## Contribute you tutorial

Create a PR with your changes. 
Please **do not** include the generated `*.html` file, but **do include** the `codelab.json` file that has been generated.

# Need help?

If you need help, please reach out to us in the [Keptn Slack](https://slack.keptn.sh) or file an issue in this repo.
