#!/bin/sh

scname=$1
replica_count=$2

cat <<EOF
---
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: $scname
  annotations:
    openebs.io/cas-type: cstor
    cas.openebs.io/config: |
      - name: StoragePoolClaim
        value: "${scname}-spc"
      - name: ReplicaCount
        value: "3"
    storageclass.kubernetes.io/is-default-class: 'false'
provisioner: openebs.io/provisioner-iscsi
---
kind: StoragePoolClaim
apiVersion: openebs.io/v1alpha1
metadata:
  name: ${scname}-spc
  annotations:
    cas.openebs.io/config: |
      - name: PoolResourceRequests
        value: |-
          memory: 2Gi
      - name: PoolResourceLimits
        value: |-
          memory: 4Gi
spec:
  name: ${cstor}-spc
  type: disk
  poolSpec:
    poolType: striped
  blockDevices:
    blockDeviceList:
EOF
kubectl get bd -n openebs | grep Unclaimed | awk '{printf "      - %s\n", $1}'
