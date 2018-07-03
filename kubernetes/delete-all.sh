#!/usr/bin/env bash

kubectl delete deployment mysql
kubectl delete service mysql
kubectl delete service,deployment backatcha-server
kubectl delete service,deployment hippo
kubectl delete ingress ingress-tutorial
