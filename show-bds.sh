#!/bin/sh

kubectl get bd -n openebs -o custom-columns=NAME:spec.claimRef.name,\
NODE:spec.nodeAttributes.nodeName,\
PATH:spec.path,\
CLAIM:status.claimState,\
STATE:status.state
