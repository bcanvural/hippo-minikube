#!/usr/bin/env bash

#Create once the persistent volumes and persistent volume claims
#Once per minikube instance.
#Run again if you ran `minikube delete` before
kubectl create -f mysql-pv.yaml