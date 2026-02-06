#!/bin/sh

KGATEWAY_VERSION="v2.1.2"
GATEWAY_CRDS_VERSION="v1.4.0"

# gw api
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/${GATEWAY_CRDS_VERSION}/standard-install.yaml

# kgateway
helm upgrade -i kgateway-crds oci://cr.kgateway.dev/kgateway-dev/charts/kgateway-crds \
--create-namespace --namespace kgateway-system \
--version ${KGATEWAY_VERSION} 

helm upgrade -i kgateway oci://cr.kgateway.dev/kgateway-dev/charts/kgateway \
--namespace kgateway-system \
--version ${KGATEWAY_VERSION} \
--set controller.image.pullPolicy=Always
