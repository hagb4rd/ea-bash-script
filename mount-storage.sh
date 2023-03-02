#!/bin/sh
mkdir -p /media/iso
cryptsetup luksOpen /dev/sda5 storage
mount /dev/mapper/storage /media/iso
