#!/bin/sh
# This script created by AQEMU
/usr/bin/qemu-system-x86_64  -smp 2 -soundhw ac97 -machine accel=kvm -m 2546 -cdrom "/dev/sr0" -hda "/home/eagle/.aqemu/linux.derived.qcow2" -boot order=cd,menu=on -net nic -net user -rtc base=localtime -name "Linux" $*
