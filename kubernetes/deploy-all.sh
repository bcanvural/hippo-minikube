#!/usr/bin/env bash

kubectl create -f ingress.yaml
kubectl create -f mysql-deployment.yaml
kubectl create -f backatcha-deployment.yaml
kubectl create -f hippo-deployment.yaml