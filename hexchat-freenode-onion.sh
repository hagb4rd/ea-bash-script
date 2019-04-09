#!/usr/bin/env bash
mkdir -p $HOME/.config/hexchat/certs
mkdir -p $HOME/.config/hexchat/addons
curl https://gist.githubusercontent.com/hagb4rd/32ef361b371ea65f33567775fe0befe8/raw/def0c076e2a9e472052e01479b7b3b312a076cbc/hexchat.whitelist.py > $HOME/.config/hexchat/addons/hexchat.whitelist.py
curl https://dl.hexchat.net/themes/Monokai.hct > $HOME/Downloads/theme.hct && unzip $HOME/Downloads/theme.hct -d $HOME/.config/hexchat/

keyfile="$HOME/.config/hexchat/certs/freenodeonion.pem"
. certadd.sh "$keyfile"
. fingerprint.sh "$keyfile"


