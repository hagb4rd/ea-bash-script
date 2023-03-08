#!/bin/bash
source "$HOME/.bashrc"

url="$1"
url="${url:-about:blank}"
pid="${pid:-twitter}"
#shift
shift
cmder="$@"

netdev="eth0"
#netdev=br0
netfilter="/home/e/.firejail/nolocal.net"
netfilter6="/home/e/.firejail/rejectipv6.net"
#netfilter="/home/e/.firejail/rules-ipv4.net"
#netfilter6="/home/e/.firejail/rules-ipv6.net"

#netfilter6="--netfilter6=/home/e/.firejail/halo6.net"
#enx001e101f0000

#privatehome='.mozilla,.config,.tor,torrc'


#if firejail --net.print="$pid"; then 
#filter="--net=${net} --netfilter=/etc/firejail/nolocal.net --netfilter6=/etc/firejail/nolocal6.net"
#--netfilter6="$netfilter6"
#echo $netfilter
#exit;
#fi

#if ! firejail --ls="$pid" ~; then
#	firejail --name="$pid" --profile=firefox --x11=xephyr --net="${netdev}" --netfilter=1olocal --netfilter6=/etc/firejail/nolocal6.net --dns=192.168.8.1 --private="~/twitter" --noroot --caps.drop=all --disable-mnt --private-tmp --nodbus --private-dev --machine-id --noautopulse --nou2f --nodvd --notv --novideo --ipc-namespace -- openbox &


# clean up firejail working/private-home directory
firejaildir="$HOME/firejail/twitter"
rm -rf "$firejaildir/.tor"
cp -a "$HOME/.tor" "$firejaildir"
rm $firejaildir/.Xauthority
rm -rf "${firejaildir}/.local"
rm -rf "${firejaildir}/.config"
rm -rf "${firejaildir}/.cache"
rm -rf "${firejaildir}/.mozilla/firefox/Crash*"
rm -rf "${firejaildir}/.mozilla/firefox/twitter.bak"
cp -a "${firejaildir}/.mozilla/firefox/1rymm6oy.twitter" "${firejaildir}/.mozilla/firefox/twitter.bak"
rm -rf "${firejaildir}/.mozilla/firefox/1rymm6oy.twitter"
cp -a "${firejaildir}/.mozilla/firefox/proto.twitter" "${firejaildir}/.mozilla/firefox/1rymm6oy.twitter"

args=(--name="$pid" \
	--protocol=unix,inet,inet6 \
	--profile=firefox \
	--x11=xephyr \
#	"--interface=$netdev" \
	"--net=$netdev" \
#	"--netfilter" \
	"--netfilter=${netfilter}" \
	"--netfilter6=${netfilter6}" \
#	--defaultgw=192.168.8.1 \
#	--ip=192.168.8.11 \
	--dns=192.168.8.1 \
	--private="~/firejail/${pid}" \
	--private-bin=ff,firefox,firefox-bin,uxterm,xterm,bash,sh,blackbox,openbox,openbox-session,tor \
	--shell=none \
#	--private-cache \
	--nonewprivs \
	--nogroups \
	--noroot \
	--caps.drop=all \
	--disable-mnt  \
	--private-tmp  \
	--nodbus \
	--private-dev \
	--machine-id  \
	--noautopulse \
	--nou2f \
	--nodvd \
#	--nosound \
	--apparmor \
	--no3d \
	--notv \
	--novideo \
	--ipc-namespace \
#	sh -c "retor & openbox & firefox -new-tab $url"  )
	uxterm -e "tor -f "${HOME}/torrc" & openbox & ff -new-tab $url")

echo firejail "${args[@]}"
firejail "${args[@]}"
sleep 2s
#firejail --bandwidth="$pid" set "$netdev" 24 8
#firejail --name="$pid" --protocol=unix,inet --profile=firefox --x11=xephyr --net="${netdev}" --netfilter="$netfilter" --dns=8.8.8.8 --defaultgw=192.168.8.1 --ip=192.168.8.11 --private="~/firejail/${pid}" --noroot --nonewprivs --nogroups --noroot --caps.drop=all --disable-mnt --private-tmp --nodbus --private-dev --machine-id --noautopulse --nou2f --nodvd --no3d --notv --novideo --nosound --shell=none --ipc-namespace --deterministic-exit-code qterminal

#@	sleep 3s
#	firejail 
#else
#	sleep 3s
#fi
#firejail --join="$pid" "$@"
#firejail --join="$pid" firefox -P "$@" &
#firejail --join="$pid" firefox "$@" &

