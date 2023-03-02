#!/bin/bash
export TZ="Europe/Berlin"
export dev="enx021f451e3602"
export shared=/tmp/shared0
sudo mkdir -p /tmp/shared0
sudo chown mint:mint /tmp/shared0
sudo mount -o rebind,rw /dev/sda6 /tmp/shared0

binlink() { local real_path=$(realpath $1); local base_name=$(basename $1); sudo chmod +x "$real_path"; sudo rm "/usr/local/bin/$base_name" 2> /dev/null; sudo ln -v -s "$real_path" "/usr/local/bin/$base_name"; }



cd /home/mint
tar -xf /tmp/shared0/dnscrypt-proxy-linux_x86_64-2.1.0.tar.gz 
mv linux-x86_64 dnscryptproxy
tar -xf /tmp/shared0/setup/tor-browser-linux64-10.5.6_en-US.tar.xz
binlink /home/mint/tor-browser_en-US/Browser/start-tor-browser
tar -xf /tmp/shared0/setup/node-v14.17.0-linux-x64.tar.xz
mv node-v14.17.0-linux-x64 node
binlink /home/mint/node/bin/node
binlink /home/mint/node/bin/npm
binlink /home/mint/node/bin/npx
tar -xf /tmp/shared0/setup/code-stable-x64-1620838810.tar.gz
binlink /home/mint/VSCode-linux-x64/bin/code


for f in /tmp/shared0/bin/*; do binlink $f; done
