#!/bin/bash

echo "🚀 Scanning Kubernetes Deployments for Security Issues..."
DEPLOYMENTS=$(kubectl get deployments -o jsonpath='{.items[*].metadata.name}')

for DEPLOYMENT in $DEPLOYMENTS
do
    echo "🔍 Scanning: $DEPLOYMENT"
    IMAGE=$(kubectl get deployment $DEPLOYMENT -o jsonpath='{.spec.template.spec.containers[*].image}')
    trivy image --exit-code 1 --severity HIGH,CRITICAL $IMAGE
done
