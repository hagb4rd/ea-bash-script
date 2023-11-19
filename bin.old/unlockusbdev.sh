#!/bin/sh
TRUE=0
FALSE=1

# flag tracking key-file availability
OPENED=$FALSE

# check and modprobe the USB driver if not already loaded
cat /proc/modules | busybox grep usb_storage >/dev/null 2>&1
USBLOAD=0$?
if [ $USBLOAD -gt 0 ]; then
modprobe usb_storage >/dev/null 2>&1
fi

# give the system time to settle and open the USB device
sleep 10

# check for the specifc /dev/usbkey device created by udev using /etc/udev/rules.d/99-unlock-luks.rules
if [ -b /dev/disk/by-uuid/48BE-69A5 ]; then
# if device exists then output the keyfile from the usb key (hidden key is 4096 bytes long starting at 2048 bytes)
dd if=/dev/usbkey bs=512 skip=4 count=8 | cat
OPENED=$TRUE
fi

if [ $OPENED -ne $TRUE ]; then
echo "FAILED to get USB key file ..." >&2
if [ -x /bin/plymouth ] && plymouth --ping; then
plymouth ask-for-password --prompt "Enter passphrase"
else
/lib/cryptsetup/askpass "Enter passphrase"
fi
else
echo "Success loading key file. Moving on." >&2
fi

sleep 1
exit 0