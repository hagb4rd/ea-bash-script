#!/bin/bash
source "$HOME/.bashrc"

url=$1

echo URL: "$url"


pid="${pid:-twitter}"
#shift
shift
# $termcmd is passed to uxterm -e $termcmd
#termcmd="openbox --sm-disable --startup \"$openboxstartup\" & tor -f $HOME/torrc"
#termcmd="tor -f $HOME/torrc & openbox --sm-disable --startup \"$openboxstartup\""
#termcmd="uxterm"
termcmd="$openboxstartup"

#termcmd="tor -f ${HOME}/torrc & openbox & ff -new-tab $url"
#verbose=""
netfilter="/home/e/.firejail/nolocal.net"
netfilter6="/home/e/.firejail/rejectipv6.net"
#netfilter="/home/e/.firejail/rules-ipv4.net"
#netfilter6="/home/e/.firejail/rules-ipv6.net"
#netfilter6="/home/e/.firejail/nolocal6.net"
#if ! firejail --ls="$pid" ~; then
#	firejail --name="$pid" --profile=firefox --x11=xephyr --net="${netdev}" --netfilter=1olocal --netfilter6=/etc/firejail/nolocal6.net --dns=192.168.8.1 --private="~/twitter" --noroot --caps.drop=all --disable-mnt --private-tmp --nodbus --private-dev --machine-id --noautopulse --nou2f --nodvd --notv --novideo --ipc-namespace -- openbox &

# clean up local home cache
rm -rf "$HOME/.cache/google-chrome"
rm -rf "$HOME/.cache/chromium"
rm -rf "$HOME/.cache/mesa_shader_cache"
rm -rf "$HOME/.cache/mozilla"
rm -rf $HOME/.cache/thumbnails/*
rm -rf "$HOME/.cache/fontconfig"
rm -rf "$HOME/.cache/cs_backgrounds"
rm -rf /run/user/1000/at*

# clean up firejail working/private-home directory
firejaildir="$HOME/firejail/twitter"

#restore local .tor data-dictionary
rm -rf "$firejaildir/.tor"
cp -a "$verbose" "$HOME/.tor" "$firejaildir"

dnscryptbackup="/home/e/Downloads/backup/dnscrypt/linux-x86_64"
dnscryptdir="${firejaildir}/dnscrypt"
#rm -rf "$dnscryptdir"
#cp -a "$dnscryptbackup" "$dnscryptdir"

#rm $firejaildir/.Xauthority
#rm -rf "${firejaildir}/.local"
#rm -rf "${firejaildir}/.config"
rm -rf "${firejaildir}/.mozilla/firefox/Crash*"

# __TEMPOFF
"$HOME/.local/bin/f-restore" "$firejaildir"
netdev=eth0
args=(--name="$pid" \
	--protocol=unix,inet,inet6 \
	--noprofile
  --x11=xephyr \
#  --xephyr-fullscreen \
  --xephyr-screen=1680x1050 \
#	"--interface=$netdev" \
	"--net=$netdev" \
#	"--netfilter" \
	"--netfilter=${netfilter}" \
	"--netfilter6=${netfilter6}" \
#  --defaultgw=10.16.0.1 \
#  --ip=10.18.0.11 \
	--defaultgw=192.168.8.1 \
# --ip="2a02:3035:40f:3b86:10:2030:4050:2"
#  "--dns=fe80::210:20ff:fe30:4050" \
#	--ip=192.168.8.11 \
#	--dns=8.8.8.8 \
	--dns=192.168.8.1 \
	--private="~/firejail/${pid}" \
	--private-cwd="$HOME" \
#  --private-bin="google-chrome,xterm,uxterm,sh,bash,blackbox,openbox,openbox-session,tor,which" \
#	--shell=none \
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
	--env=OPENURI="$url" \
  --env=QT_ACCESSIBILITY=0 \
  --env=LC_CALL=C \
  --env=LC_ALL="C.UTF-8" \
	--env=LANG="C.UTF-8" \
#  --env=GTK3_MODULES="" \
#	uxterm -e "$termcmd")
#	openbox --sm-disable --startup "$termcmd")
   openbox-session)

echo firejail "${args[@]}"
echo ---------------------------------
firejail "${args[@]}"
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
