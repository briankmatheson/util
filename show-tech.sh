#!/bin/sh

touch /tmp/maya-tech-support

while read line; do
		$line >> /tmp/maya-tech-support
		done <<EOF
kubectl version
kubectl get nodes
kubectl get bd -A
kubectl get spc
kubectl get csp
kubectl get sp
kubectl get pvc -A
kubectl get pv
kubectl get all -n openebs		
kubectl cluster-info dump -A
EOF

cat /tmp/maya-tech-support | gzip -c > ./maya-tech-support.gz
