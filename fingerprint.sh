#!/usr/bin/env bash
file="$1"
openssl x509 -in "$file" -outform der | sha1sum -b | cut -d \  -f1
