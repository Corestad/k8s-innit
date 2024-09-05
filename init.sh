#!/bin/bash

# Cert manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.15.3/cert-manager.yaml;

# Cert manager resources are created, but the webhook pod needs a little bit extra time to go online;
kubectl -n cert-manager wait --for=condition=ready pod -l app=webhook;
# plus a little bit more to make sure the https works properly for the webhook svc
# INFO: if this is not working out an error will emerge that the cert-manager-webhook is unreachable or something similar
# 			just wait a little and run the whole script again.
sleep 20;


kubectl apply -f ./init/;

