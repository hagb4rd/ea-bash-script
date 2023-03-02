#!/bin/sh
# This script created by AQEMU
/usr/bin/qemu-system-x86_64  -smp 2 -soundhw hda -machine accel=kvm -m 2846 -snapshot -cdrom "/dev/sr0" -hda "/media/iso/buster0.qcow2" -virtfs local,id=shared_folder_dev_0,path=/tmp/shared0,security_model=none,mount_tag=shared0 -boot once=c,menu=on -net nic,macaddr=00:d1:96:f8:c4:11,model=virtio-net-pci -net tap,ifname=tap0,script=no -usb -usbdevice mouse -usbdevice mouse -rtc base=utc,driftfix=slew -name "Linux2" $*
