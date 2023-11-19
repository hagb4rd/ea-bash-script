#!/bin/sh
#---------------------------------------------
# save as /usr/local/sbin/openluksdevices.sh
#---------------------------------------------
# source -- https://gist.github.com/da-n/4c77d09720f3e5989dd0f6de5fe3cbfb


# In this tutorial, the secret key for decryption of the volume is added in /dev/sda3 only. However, it can be added to /dev/sda2 (swap) partition as well.

## cryptsetup luksAddKey /dev/sda3 /root/secret.key --key-slot 1

# A simple udev rule is created for the USB device  
# in the file /etc/udev/rules.d/99-custom-usb.rules, # 
# the symbolic link that we will use is /dev/usbdevice.

## SUBSYSTEMS=="usb", DRIVERS=="usb",SYMLINK+="usbdevice%n"


# Reload rules using the following command.

## udevadm control --reload-rules

# Insert the USB device to verify the custom rule.

# A shell script is required to read the secret key from the USB device and provide it to cryptsetup at boot time. The script is created as /usr/local/sbin/openluksdevices.sh and taken from the http://www.oxygenimpaired.com/ site.


############taken from following link#########
###http://www.oxygenimpaired.com/debian-lenny-luks-encrypted-root-hidden-usb-keyfile

TRUE=0
FALSE=1

# flag tracking key-file availability
OPENED=$FALSE

if [ -b /dev/usbdevice ]; then
# if device exists then output the keyfile from the usb key 
dd if=/dev/usbdevice bs=512 skip=4 count=16 | cat
OPENED=$TRUE
fi

if [ $OPENED -ne $TRUE ]; then
echo "FAILED to get USB key file ..." >&2
/lib/cryptsetup/askpass "Try LUKS password: "
else
echo "Success loading key file for Root . Moving on." >&2
fi

sleep 2

#--------------------------------------------------
# Set the permissions of script so that it can be executed.

## chmod a+x /usr/local/sbin/openluksdevices.sh

# Similar to the fstab configuration file, 
# the /etc/crypttab file contains the information about encyrpted volumes on the Linux platfrom. Add a shell script for the sda3_crypt encrypted partition. The content of configuration file /etc/crypttab for encrypted volume is given below.

## sda3_crypt /dev/disk/by-uuid/c37a8128-5ea9-45c6-8890-d52f3d452ccc none luks,keyscript=/usr/local/sbin/openluksdevices.sh

# Add the following line in the 
# /etc/initramfs-tools/conf.d/cryptroot file.

## CRYPTROOT=target=sda3_crypt,source=/dev/disk/by-uuid/c37a8128-5ea9-45c6-8890-d52f3d452ccc

# Setting up hooks for USB key drive
### ----> udevusbkey.sh