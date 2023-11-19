#!/bin/sh
backup=/media/sda5/KNOPPIX
target=/home/knoppix
c=chromium

rm -rf $target/.cache/$c
rm -rf $target/.config/$c

cp -R $backup/.cache/$c  $target/.cache
chown -R knoppix.knoppix $target/.cache/$c

cp -R $backup/.config/$c  $target/.config
chown -R knoppix.knoppix $target/.config/$c