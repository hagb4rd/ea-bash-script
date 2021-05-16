#!/bin/sh
backup=/media/sda5/KNOPPIX
target=/home/knoppix
c=chromium

rm -rf $backup/.cache/$c
rm -rf $backup/.config/$c

cp -R $target/.cache/$c  $backup/.cache
chown -R knoppix.knoppix $backup/.cache/$c

cp -R $target/.config/$c  $backup/.config
chown -R knoppix.knoppix $backup/.config/$c