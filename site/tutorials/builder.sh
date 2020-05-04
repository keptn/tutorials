#!/bin/bash
BASE_DIR=site/tutorials/

git diff --name-only > changedfiles.txt || echo ""
CHANGED_FILES=$(tr '\n' ' ' < changedfiles.txt)

for filepath in $CHANGED_FILES; do
  #echo $filepath
  newpath="${filepath/$BASE_DIR/}"  
  # only build from root folder and only *.md files (no tutorial-template, no readme)
  if [[ $newpath != *"/"* ]] && [[ $newpath == *".md"* ]] && \
    [[ $newpath != *"_gen.md"* ]] && \
    [[ $newpath != *"tutorial-template.md"* ]] && \
    [[ $newpath != *"README.md"* ]]; then

    echo $newpath
    ./markymark $newpath
    claat export -ga "UA-133584243-1" ${newpath/.md/_gen.md}
  fi
done

# now serve the content to check locally
#claat serve
