#!/bin/sh
mkdir -p /media/iso
cryptsetup luksOpen /dev/sda5 iso
mount /dev/mapper/iso /media/iso
chown -R eagle.eagle /media/iso
