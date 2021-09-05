#!/bin/sh
sudo mkdir -p /tmp/shared0
sudo mkdir -p /shared
sudo chown -hR earendel.earendel /tmp/shared0
sudo mount -t 9p -o trans=virtio shared0 /tmp/shared0/ -o version=9p2000.L,posixacl,cache=mmap
#sudo mount --bind /tmp/shared0 /shared
sudo /usr/local/bin/iptables.sh
sudo /tmp/shared0/bin/rc.local

