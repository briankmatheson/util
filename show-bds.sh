#!/bin/sh

kubectl get bd -n openebs -o custom-columns=NAME:spec.claimRef.name,\
NODE:spec.nodeAttributes.nodeName,\
PATH:spec.path,\
SIZE:spec.capacity.storage,\
MODEL:spec.details.model,\
CLAIM:status.claimState,\
STATE:status.state
