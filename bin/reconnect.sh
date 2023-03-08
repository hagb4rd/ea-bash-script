#!/bin/bash
ifconfig $dev down
dhclient -r $dev
sleep 1s
ifconfig $dev up && dhclient $usb
sleep 1s
dig faceboook.com
ip route list
