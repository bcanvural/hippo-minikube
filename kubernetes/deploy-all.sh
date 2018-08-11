#!/usr/bin/env bash
set -x
kubectl create -f ingress.yaml
kubectl create -f mysql-deployment.yaml
kubectl create -f backatcha-deployment.yaml
kubectl create -f hippo-deployment.yaml


