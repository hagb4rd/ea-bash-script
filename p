#!/bin/bash
separator="";
for f in "$@"; do printf %s%s "$separator" "${f}"; separator=$'\n'; done
#if ((stdin)); then 
#    while read line; do 
#        echo "$line";
#    done
#fi


#    printf 
