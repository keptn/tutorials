#!/bin/bash

allEnvs=(aks eks gke openshift pks minikube)

for e in ${allEnvs[@]}; do
  echo keptn-install-$e.md
  ./markymark keptn-install-$e.md && claat export keptn-install-$e\_gen.md 
done

