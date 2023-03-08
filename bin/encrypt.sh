#!/bin/sh
cryptsetup -y -v luksFormat /dev/sda6		
cryptsetup luksOpen /dev/sda6 storage
cryptsetup -v status storage
cryptsetup luksDump /dev/sda6
dd if=/dev/zero of=/dev/mapper/storage status=progress bs=128M