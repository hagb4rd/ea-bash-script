#!/bin/sh
# ----------
# chmod a+x /etc/initramfs-tools/hooks/udevusbkey.sh
# ----------
# source -- https://gist.github.com/da-n/4c77d09720f3e5989dd0f6de5fe3cbfb


# Make sure the usb_storage is added in 
# /etc/initramfs-tools/modules file.

# The following shell script (/etc/initramfs-tools/hooks/udevusbkey.sh) 
# is also taken from an external source. It is used to add a custom udev rule in the temporary file system initrd.


# udev-usbkey script
###taken from
###http://www.oxygenimpaired.com/ubuntu-with-grub2-luks-encrypted-lvm-root-hidden-usb-keyfile
PREREQ="udev"
prereqs()
{
echo "$PREREQ"
}

case $1 in
prereqs)
prereqs
exit 0
;;
esac

. /usr/share/initramfs-tools/hook-functions

# Copy across relevant rules

cp /etc/udev/rules.d/99-custom-usb.rules ${DESTDIR}/lib/udev/rules.d/

exit 0


# Change the permission of the script.

## chmod a+x /etc/initramfs-tools/hooks/udevusbkey.sh

# Some changes are required in the GRUB2 boot loader configuation. However, direct changes in the configuration file /boot/grub/grub.cfg are not allowed. Therefore, change GRUB_CMDLINE_LINUX_DEFAULT parameter in the /etc/default/grub configuration file. 
# As shown below, rootdelay and cryptopts are included in the 
# GRUB_CMDLINE_LINUX_DEFAULT parameter.

## GRUB_CMDLINE_LINUX_DEFAULT="rootdelay=20 cryptopts=target=sda3_crypt,source=/dev/disk/by-uuid/c37a8128-5ea9-45c6-8890-d52f3d452ccc,keyscript=/lib/cryptsetup/scripts/openluksdevices.sh"
## GRUB_CMDLINE_LINUX=""

# Uncomment to enable BadRAM filtering, modify to suit your needs
# This works with Linux (no patch required) and with any kernel that obtainsConclusion

# Run the update-grub command to apply above changes in the
# /boot/grub/grub.cfg configuration file.

## update-grub

# After above command, the following changes got applied in the /boot/grub/grub.cfg configuration file.

## echo    'Loading Linux 3.16.0-4-686-pae ...'
## linux   /vmlinuz-3.16.0-4-686-pae root=UUID=b30cdb22-8e3c-4ffd-a0c7-af96b90ba016 ro  rootdelay=20 cryptopts=target=sda3_crypt,source=/dev/disk/by-uuid/c37a8128-5ea9-45c6-8890-d52f3d452ccc,keyscript=/lib/cryptsetup/scripts/openluksdevices.sh
## echo    'Loading initial ramdisk ...'
## initrd  /initrd.img-3.16.0-4-686-pae
## Run update-initramfs -u to update the temporary file system file for all kernels.

## update-initramfs -u

# Before reboot, unpack the newley generated initrd.img and verify that the keyscript 
# has been copied to the lib/cryptsetup/scripts directory 
# and the custom udev rule into lib/udev/rules.d/ directory.

## cd /tmp/
## zcat /boot/initrd.img-3.16.0-4-686-pae | cpio -iv