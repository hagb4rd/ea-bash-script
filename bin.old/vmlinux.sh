#!/bin/sh
# This script created by AQEMU
/usr/bin/qemu-system-x86_64  -smp 2 -soundhw ac97 -machine accel=kvm -m 3183 -snapshot -hda "/home/eagle/.aqemu/linux.derived.qcow2" -boot once=c,menu=on -net nic -net user -rtc base=utc,driftfix=slew -name "Linux" $*
