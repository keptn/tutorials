# How to write your own tutorial

To get a full setup of Google Codelabs you can follow this tutorial https://medium.com/@zarinlo/publish-technical-tutorials-in-google-codelab-format-b07ef76972c. However, not everything is needed to get started.

## Tools needed

- Go language
- Node.js v10+ and npm
- [claat](https://github.com/googlecodelabs/tools/tree/master/claat#install)

## Write your tutorial

Start your tutorial by taking a look at the `tutorial-template.md` file in this folder. You can just duplicate the file and adopt it to get started easily. The contents of the file should be self-explanatory.

## Generate contents and test locally

1. If you used any snippets in your tutorial markdown file use the tool [markymark](https://github.com/jetzlstorfer/markymark) to replace the placeholders in the form of `{{ path/to/file.md }}` with the actual file contents and to generate a new file called `tutorial-template_gen.md`.
    ```
    markymark tutorial-template.md
    ```

1. Generate local preview (this will actually generate a new folder named after the ID you put inside your template file). This will open a browser window.
    ```
    claat export tutorial-template_gen.md && claat serve
    ```
  
1. To generate not only the local preview for the tutorials themselves but also the overview page of all tutorials, execute the following command from the `tutorials/site` folder and navigate to the URL that is given to you after executing the command:
    ```
    gulp serve --codelabs-dir=tutorials
    ```
