#!/bin/bash
dns1=8.8.8.8
dns2=8.8.4.4 
#dns1=9.9.9.10
#dns2=8.8.4.4
#dhclient -r usb0
#ifconfig usb0 down 
#ifconfig usb0 up && dhclient usb0  
ifconfig $dev down
#ifconfig usb0 up
ifconfig $dev 192.168.42.1111 netmask 255.255.255.0 broadcast 192.168.42.255
echo nameserver $dns1 > /etc/resolv.conf
echo nameserver $dns2 >> /etc/resolv.conf
route add default gw 192.168.42.129
echo ---------------------------
echo DNS lookup google.com
echo ---------------------------
dig google.com 
echo --------------------------
echo DNS lookup twitter.com
echo -------------------------
dig twitter.com
echo -------------------------
echo 'netstat -tulpn && ip route'
netstat -tulpn
echo --------------------------
ip route 
echo --------------------------
