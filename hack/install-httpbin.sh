#!/bin/sh

kubectl apply -f https://raw.githubusercontent.com/kgateway-dev/kgateway/refs/heads/v2.1.x/examples/httpbin.yaml

kubectl apply -f- <<EOF
kind: Gateway
apiVersion: gateway.networking.k8s.io/v1
metadata:
  name: http
  namespace: kgateway-system
spec:
  gatewayClassName: kgateway
  listeners:
  - protocol: HTTP
    port: 8080
    name: http
    allowedRoutes:
      namespaces:
        from: All
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: httpbin
  namespace: httpbin
spec:
  parentRefs:
    - name: http
      namespace: kgateway-system
  hostnames:
    - "kgateway.local"
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /k8s
      filters:
        - type: URLRewrite
          urlRewrite:
            path:
              type: ReplacePrefixMatch
              replacePrefixMatch: /
      backendRefs:
        - name: httpbin
          port: 8000
EOF
