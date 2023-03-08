#!/bin/sh
mkdir -p /windows
cryptsetup luksOpen /dev/sdb3 windows
mount /dev/mapper/windows /windows
chown eagle.eagle /windows

