#!/bin/bash
BASE_DIR=site/tutorials/

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=darwin;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo ${machine}

process_single_file() {
  ./bin/markymark-$machine $1
  ./bin/claat-$machine export -ga "UA-133584243-1" ${1/.md/_gen.md}
}

process_all_files() {
  ## if no file is given, check for changed files
  #git diff --name-only > changedfiles.txt || echo ""
  #CHANGED_FILES=$(tr '\n' ' ' < changedfiles.txt)

  #echo "changed files: " $CHANGED_FILES
  if [[ $CHANGED_FILES == "" ]]; then
    CHANGED_FILES=`ls *.md`
  fi

  for filepath in $CHANGED_FILES; do
    #echo $filepath
    newpath="${filepath/$BASE_DIR/}"  
    # only build from root folder and only *.md files (no tutorial-template, no readme)
    if [[ $newpath != *"/"* ]] && [[ $newpath == *".md"* ]] && \
      [[ $newpath != *"_gen.md"* ]] && \
      [[ $newpath != *"tutorial-template.md"* ]] && \
      [[ $newpath != *"README.md"* ]]; then

      echo $newpath
      ./bin/markymark-$machine $newpath
      ./bin/claat-$machine export -ga "UA-133584243-1" ${newpath/.md/_gen.md}
    fi
  done

  git diff --name-only > updatedfiles.txt || echo ""
  UPDATED_FILES=$(tr '\n' ' ' < updatedfiles.txt)

  ## revert codelab.json if nothing else has changed
  for filepath in $UPDATED_FILES; do
    newpath="${filepath/$BASE_DIR/}" 
    indexpath="${newpath/codelab.json/index.html}"
    #echo $indexpath
    if [[ $newpath == *"codelab.json"* ]] && [[ $UPDATED_FILES != *"$indexpath"* ]]; then
      echo "revert:" $newpath "because index.html has not changed"
      git checkout -- $newpath
    fi
  done
}

### MAIN 

## if file is given, generate content for this file
if [[ $1 != "" ]]; then
  process_single_file $1
  
else
  process_all_files

fi

# now serve the content to check locally
#claat serve
