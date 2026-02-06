#!/bin/sh

kubectl port-forward deployment/http -n kgateway-system 8080:8080 > /tmp/port-forward.log 2>&1 &
