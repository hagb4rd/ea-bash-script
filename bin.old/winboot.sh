!/bin/sh
# This script created by AQEMU
/usr/bin/qemu-system-x86_64  -soundhw ac97 -vga qxl -machine accel=kvm -m 3072 -snapshot -drive file=/dev/sr0,if=ide,index=0,media=cdrom -drive file=/media/iso/win10.qcow,if=ide,index=1,media=disk -boot once=c,menu=off -netdev user,id=net0 -device e1000,netdev=net0 -net nic -rtc base=localtime -name "Windows 7 x64" $*
