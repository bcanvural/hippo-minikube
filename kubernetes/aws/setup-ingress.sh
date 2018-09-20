#!/usr/bin/env bash
kubectl apply -f ingress-controller.yaml
kubectl apply -f service-l4.yaml
kubectl apply -f patch-configmap-l4.yaml
