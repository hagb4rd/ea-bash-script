#!/bin/bash
days=1500
file="$1"

openssl req -x509 -sha256 -nodes -days $days -newkey rsa:4096 -keyout "$file" -out "$file"
