#!/bin/bash

for file in ./*.md
do
  # do not touch generated files
  if [[ $file != *"_gen.md"* ]] && [[ $file != *"tutorial-template.md"* ]] && [[ $file != *"README.md"* ]]; then 
    ./markymark "$file"
    # export the generated files
    claat export ${file/.md/_gen.md}
  fi
done

# now serve the content to check locally
# claat serve
