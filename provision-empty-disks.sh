#!/bin/sh

usage() {
		echo
		echo $0 /path/to/drive [path2 ... pathN]
}

if [ "$USER" = "root" ]; then
		echo finding and initializing empty drives
else
		echo must run as root
		exit 1
fi

if [ $# -eq 0 ]; then
		echo nothing to do
		usage
		exit 1
fi

format_empty_drive() {
		drive=$1
		mkfs.ext4 $drive
}

add_drive_to_fstab() {
		drive=$1
		uuid=`blkid -s UUID -o value $drive`
		echo UUID=`sudo blkid -s UUID -o value $drive` /mnt/disks/$drive ext4 defaults 0 2 | tee -a /etc/fstab
}

mount_drive() {
		drive=$1
		uuid=`blkid -s UUID -o value $drive`
		mkdir -p /mnt/disks/$uuid
		mount /mnt/disks/$uuid
}

for drive in $*; do
		blkid $drive
		if [ $? -eq 2 ]; then
				format_empty_drive $drive
				add_drive_to_fstab $drive
				mount_drive $drive
		else
				echo skipping $drive
		fi
done
