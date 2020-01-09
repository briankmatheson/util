#!/bin/sh

cluster=$1
size=$2
device=$3

create_volume() {
		# make a new gp2 vol, return new VolumeId
		az=$1
		size=$2
		aws ec2 create-volume --availability-zone $az --size $size --volume-type gp2 | jq -r '.VolumeId'
}

attach_volume() {
		vol_id=$1
		inst_id=$2
		dev_name=$3

		aws ec2 attach-volume --volume-id $vol_id --instance-id $inst_id --device $dev_name
}

list_instances_in_cluster() {
		clustername=$1
aws ec2 describe-instances \
    --filter Name=tag-key,Values=Name \
    --query "Reservations[*].Instances[*].{Instance: InstanceId, AZ: Placement.AvailabilityZone, ClusterName: Tags[?Key=='alpha.eksctl.io/cluster-name'] | [].Value}" \
    --output json | \
    jq -r ".[][] | select(.ClusterName[0] == \"$clustername\") | .AZ, .Instance" | \
		while read region; do 
				read instance
				line="$region $instance"
				echo $line
		done
}

list_instances_in_cluster $cluster | \
		while read reg inst; do
				new_volume=$(create_volume $reg $size)
				aws ec2 wait volume-available --volume-ids $new_volume
				attach_volume $new_volume $inst $device
				if [ "$?" -ne 0 ]; then
						echo error: $?
				else
						echo attached new ${size}G volume $new_volume to instance $inst in $reg at $device
				fi
		done

 
