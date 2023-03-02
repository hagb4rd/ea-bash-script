#!/bin/bash
##firejail --net="${netdev}" --netfilter=/home/e/.firejail/nolocal.net --dns="192.168.8.1" --protocol=inet "$@"
if [[ -z "$1" ]]; then 
	firejail --list
else 
	firejail  "$*"
fi

