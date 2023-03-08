#!/bin/bash
name="$1"
shift
cmd="$@"

if [[ -z "$name" ]]
 then name="firebox"
fi
if [[ -z "$dev" ]]
	then dev=ens3
else 
	dev=br0
fi

net="$dev"

if ! firejail --net.print="$name"; then  
	firejail --noprofile --noprofile --name="$name" --x11=xephyr --net="$net" --netfilter  --caps.drop=all --disable-mnt --nonewprivs  --private-cache --private-home=torbrowser,.mozilla --noroot --nodbus --private-dev --private-tmp  --machine-id  --nosound --noautopulse --nou2f --nodvd  --notv --ipc-namespace  openbox &
	sleep 3
fi
if [[ ! -z "$cmd" ]]; then
	firejail --join="$name" "$cmd[@]"
fi