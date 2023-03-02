#!/bin/bash

if [[ ! -d /tmp/shared0 ]]; then
	sudo mkdir -p /tmp/shared0
	sudo chown -hR earendel.earendel /tmp/shared0
fi

if [[ ! -d /tmp/shared0/bin ]]; then
	sudo mount -t 9p -o trans=virtio shared0 /tmp/shared0/ -o version=9p2000.L,posixacl,cache=mmap
fi

cd /tmp/shared0/bin
 
for f in * 
do 
	sudo /tmp/shared0/bin/binlink "$f"
done
