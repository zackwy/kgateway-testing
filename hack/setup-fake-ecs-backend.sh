#!/bin/sh

kubectl apply -f - <<EOF
apiVersion: gateway.kgateway.dev/v1alpha1
kind: Backend
metadata:
  name: fake-ecs-lb
spec:
  type: Static
  static:
    hosts:
      - host: lb
        port: 80
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: ecs-backend-route
spec:
  parentRefs:
    - name: kgateway
      namespace: kgateway-system
  hostnames:
    - "ecs.kgateway.local"
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /
      backendRefs:
      - name: fake-ecs-lb
        kind: Backend
        group: gateway.kgateway.dev
EOF
