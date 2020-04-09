#!/bin/bash

cat keptn-install.md installation/keptnK8s.md installation/keptnCLI.md > install.md

echo $1

claat export -e $1 install.md && claat serve 
