#!/usr/bin/env bash
set -x
kubectl delete deployment mysql
kubectl delete service mysql
kubectl delete service,deployment backatcha-server
kubectl delete service,deployment hippo
kubectl delete service,deployment site-only
kubectl delete ingress ingress-site
kubectl delete ingress ingress-cms
kubectl delete ingress ingress-backatcha
