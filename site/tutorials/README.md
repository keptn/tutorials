[![Netlify Status](https://api.netlify.com/api/v1/badges/244ac853-f6f6-4005-a02a-ec7ba2a2b4e1/deploy-status)](https://app.netlify.com/sites/keptn-tutorials/deploys)

# How to write your own tutorial

To get a full setup of Google Codelabs you can follow this tutorial https://medium.com/@zarinlo/publish-technical-tutorials-in-google-codelab-format-b07ef76972c. However, not everything is needed to get started.

## Tools needed

- Go language
- Node.js v10+ and npm
- [claat](https://github.com/googlecodelabs/tools/tree/master/claat#install)

## Write your tutorial

Start your tutorial by taking a look at the `tutorial-template.md` file in this folder. You can just duplicate the file and adopt it to get started easily. The contents of the file should be self-explanatory.

## Generate contents and test locally

1. Generate ONLY ONE tutorial and test it locally

    ```
    ./builder.sh my-tutorial.md

    claat serve
    ```

1. Generate ALL tutorial and test it locally
    ```
    ./builder.sh 

    claat serve
    ```

### Generate without builder.sh file
1. If you used any snippets in your tutorial markdown file use the tool [markymark](https://github.com/jetzlstorfer/markymark) to replace the placeholders in the form of `{{ path/to/file.md }}` with the actual file contents and to generate a new file called `tutorial-template_gen.md`.
    ```
    markymark tutorial-template.md
    ```

1. Generate local preview (this will actually generate a new folder named after the ID you put inside your template file). **Please note** to use the *_gen.md* file for claat as otherwise the generates files won't show the inserted snippets. 
    ```
    claat export -ga "UA-133584243-1" tutorial-template_gen.md 

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

