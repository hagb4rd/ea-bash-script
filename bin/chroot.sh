#!/bin/bash 

mnt='/target'

# /
# cryptsetup luksOpen /dev/sdb3 crypt
# mount /dev/mapper/crypt $mnt
# mount /dev/sda4 $mnt

# /boot
# mount /dev/sdb2 $mnt/boot
# https://gist.github.com/da-n/4c77d09720f3e5989dd0f6de5fe3cbfb
# /home
# mount /dev/sda5 $mnt/home

# Bind mount various virtual filesystems:
for i in /dev /dev/pts /proc /sys /sys/firmware/efi/efivars /run; do mount --rebind $i $mnt$i; done

# Chroot into the broken system:
# chroot $mnt

# Reinstall GRUB to the appropriate disk (without partition number):
# grub-install /dev/sda

# Generate the GRUB configuration file:
# update-grub
