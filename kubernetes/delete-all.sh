#!/usr/bin/env bash

kubectl delete deployment mysql
kubectl delete service mysql
kubectl delete service,deployment backatcha-server
kubectl delete service,deployment hippo
kubectl delete ingress ingress-site
kubectl delete ingress ingress-cms
kubectl delete ingress ingress-backatcha
kubectl delete pvc mysql-pv-claim
#kubectl delete pv task-pv-volume

