#!/usr/bin/env bash

#Create once the persistent volumes and persistent volume claims
#Once per minikube instance.
#Run again if you ran `minikube delete` before
kubectl create -f mysql-pv.yaml
#Create secret which carries the mysql password
kubectl create secret generic mysql-pass --from-literal=password=hippo