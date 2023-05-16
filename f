#!/bin/bash
#source "$HOME/.bashrc"

#netdev="none"
url=$1
if [[ -z "$url" ]]; then
	url="about:blank"
  openboxstartup="firefox --no-remote -P"
else 
  openboxstartup="firefox -new-tab '$url'"
fi
openboxstartup="sh -c 'firefox --no-remote'"
echo URL: "$url"
pid="openbox"
# clean up firejail working/private-home directory
firejaildir="$HOME/firejail/$pid"
mkdir -p "$HOME/firejail"
mkdir -p "$firejaildir"


netfilter="/home/e/.firejail/nolocal.net"
#netfilter6="/home/e/.firejail/rejectipv6.net"
#netfilter="/home/e/.firejail/rules-ipv4.net"
netfilter6="/home/e/.firejail/rules-ipv6.net"
#netfilter6="/home/e/.firejail/nolocal6.net"
#shift
shift
firefoxcmd="firefox --profile /home/e/.mozilla/firefox/1rymm6oy.twitter $url"
#firefox
netdev=br0
args=(--name="$pid" \
	--protocol=unix,inet,inet6 \
#  --noprofile \
	--profile=firefox \
  --apparmor \
  --x11=xephyr \
  --xephyr-screen=1680x1050 \
#	"--interface=$netdev" \
#  --writable-var \
	"--net=$netdev" \
#	"--netfilter" \
	"--netfilter=${netfilter}" \
	"--netfilter6=${netfilter6}" \
#  --defaultgw=192.168.8.1 \
#  --ip=10.18.0.11 \
#	--defaultgw=192.168.8.1 \
#  --ip=dhcp \ 
#  --ip6=dhcp \
# --ip="2a02:3035:40f:3b86:10:2030:4050:2"
#  "--dns=fe80::210:20ff:fe30:4050" \
#	--ip=192.168.8.11 \
  --dns=1.1.1.1 \
	--dns=8.8.8.8 \
	--private-cwd="$HOME" \
  --noinput \
	--noroot \
	--private="~/firejail/${pid}" \
#  --private-bin="firefox,firefox-bin,xterm,uxterm,sh,bash,blackbox,openbox,openbox-session,which" \
  --private-bin="firefox,firefox-bin,bash,sh,openbox,openbox-session,which" \
#	--shell=none \
#	--private-cache \
	--nonewprivs \
	--nogroups \
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
#	--no3d \
	--notv \
	--novideo \
	--ipc-namespace \
	--env=OPENURI="$url" \
  --env=QT_ACCESSIBILITY=0 \
#  --env=LC_CALL=C \
#  --env=LC_ALL="C.UTF-8" \
	--env=LANG="C.UTF-8" \
#  --env=GTK3_MODULES="" \
#	uxterm -e "$termcmd")
#	openbox --sm-disable --startup "$termcmd")
#   openbox --sm-disable --startup "uxterm -e 'tor -f torrc'")
   openbox --sm-disable --startup "$firefoxcmd")

#   openbox --sm-disable --startup "firefox --no-remote")

echo firejail "${args[@]}"
echo ---------------------------------

if ! firejail --ls=$pid ~; then


  # archive and presort downloaded files
  "$HOME/.local/bin/f-archive" "$firejaildir"

  # clean up local home cache
  rm -rf "$HOME/.cache/google-chrome"
  rm -rf "$HOME/.cache/chromium"
  rm -rf "$HOME/.cache/mesa_shader_cache"
  rm -rf "$HOME/.cache/mozilla"
  rm -rf $HOME/.cache/thumbnails/*
  rm -rf "$HOME/.cache/fontconfig"
  rm -rf "$HOME/.cache/cs_backgrounds"
  rm -rf /run/user/1000/at*


  #restore local .tor data-dictionary
  #rm -rf "$firejaildir/.tor"
  #cp -a "$verbose" "$HOME/.tor" "$firejaildir"

  dnscryptbackup="/home/e/Downloads/backup/dnscrypt/linux-x86_64"
  dnscryptdir="${firejaildir}/dnscrypt"
  #rm -rf "$dnscryptdir"
  #cp -a "$dnscryptbackup" "$dnscryptdir"

  #rm $firejaildir/.Xauthority
  #rm -rf "${firejaildir}/.local"
  #rm -rf "${firejaildir}/.config"
  rm -rf "${firejaildir}/.mozilla/firefox/Crash*"

  rm -rf "${firejaildir}/cnd"
  cp -a $HOME/git/http/cdn "${firejaildir}"

  # __TEMPOFF
  "$HOME/.local/bin/f-restore" "$firejaildir"
  firejail "${args[@]}"
else 
  firejail --join=$pid firefox --profile "$HOME/.mozilla/firefox/1rymm6oy.twitter" -private-window "$url" < /dev/null
fi

#if [[ ! -z $url ]]; then 
#firejail --join=$pid firefox --profile "$HOME/.mozilla/firefox/1rymm6oy.twitter" --new-tab "$url" 
#fi
#if [[ ! -z $url ]]; then 
#firejail --join=$pid google-chrome --proxy-server="socks://localhost:9050" "$url"
#fi




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
