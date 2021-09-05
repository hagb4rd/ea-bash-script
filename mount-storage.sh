#!/bin/sh
mkdir /storage
cryptsetup luksOpen /dev/sda6 storage
mount /dev/mapper/storage /storage