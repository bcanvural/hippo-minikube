#!/usr/bin/env bash

#kubectl delete pv mysql-pv-volume
#kubectl delete pvc mysql-pv-claim
kubectl delete deployment mysql
kubectl delete service mysql
kubectl delete service,deployment backatcha-server
kubectl delete service,deployment hippo
kubectl delete ingress ingress-tutorial

#kubectl create -f mysql-pv.yaml #Create once and don't delete every time
kubectl create -f ingress.yaml
kubectl create -f mysql-deployment.yaml
kubectl create -f backatcha-deployment.yaml
kubectl create -f hippo-deployment.yaml


