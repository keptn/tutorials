[![Netlify Status](https://api.netlify.com/api/v1/badges/244ac853-f6f6-4005-a02a-ec7ba2a2b4e1/deploy-status)](https://app.netlify.com/sites/keptn-tutorials/deploys)

# How to write your own tutorial

To get a full setup of Google Codelabs you can follow this tutorial https://medium.com/@zarinlo/publish-technical-tutorials-in-google-codelab-format-b07ef76972c. However, not everything is needed to get started.

## Tools needed if builder.sh is NOT used

- [claat](https://github.com/googlecodelabs/tools/tree/master/claat#install) (included in this repo for mac and linux, for windows please go ahead and download it)

For development:
- Go language
- Node.js v10+ and npm

## Write your tutorial

Start your tutorial by taking a look at the `tutorial-template.md` file in this folder. You can just duplicate the file and adopt it to get started easily. The contents of the file should be self-explanatory.

## Generate contents and test locally

1. Generate ONLY ONE tutorial and test it locally

    ```
    ./builder.sh my-tutorial.md

    claat serve
    ```

1. Generate ALL tutorials and test it locally
    ```
    ./builder.sh 

    claat serve
    ```

  
### Generate overview site

- To generate not only the local preview for the tutorials themselves but also the overview page of all tutorials, execute the following command and navigate to the URL that is given to you after executing the command:
    ```
    gulp serve 
    ```

- If you want to generate the content without starting the server for preview, execute the following command:
    ```
    gulp dist
    ```

