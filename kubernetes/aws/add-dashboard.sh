#!/usr/bin/env bash
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl create -f dashboard-admin.yaml
kops get secrets kube --type secret -oplaintext
kubectl cluster-info