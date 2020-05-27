#!/bin/bash

infra_hosts=`kubectl --no-headers=true get pod -n openebs -owide | awk '{print $7}' | sort -u`
echo OpenEBS Enterprise Infrastructure hosts:
for h in $infra_hosts; do
		echo $h
done

echo OpenEBS Enterprise Infrastructure consumers:

kubectl --no-headers=true get pv -A -o 'custom-columns=NAME:metadata.name,ANNOTATIONS:metadata.annotations' | tr ']' ' ' | while read name rest
do
		for word in $rest
		do
				case "$word" in
						openebs.io/cas-type:cstor)
								echo $rest | sed -E 's/^.+openEBSProvisionerIdentity:(\w+) .+$/\1/'
								 ;;
  			esac
		done
done >>/tmp/nodes.$$.tmp
consumers=`sort -u </tmp/nodes.$$.tmp`
rm -r /tmp/nodes.$$.tmp
echo $consumers
all_hosts=`echo $consumers $infra_hosts | tr ' ' '\n' | sort -u`
count=`echo $all_hosts | wc -w`
echo $count total OpenEBS Licenses in use
