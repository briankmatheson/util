#!/bin/sh

touch /tmp/maya-tech-support

while read line; do
		echo "# $line" >> /tmp/maya-tech-support.$$
		$line >> /tmp/maya-tech-support.$$
		done <<EOF
kubectl version
kubectl get nodes
kubectl get bd -A -owide
kubectl get sp
kubectl get spc
kubectl get csp
kubectl get ns
kubectl get pvc -A
kubectl get pv
kubectl get cvr -A
kubectl get pods -n openebs -owide
kubectl describe all -n openebs
kubectl logs -n openebs
kubectl get pods -n maya-system -owide
kubectl describe all -n maya-system
EOF



cat /tmp/maya-tech-support.$$ | gzip -c > ./maya-tech-support.gz
