#!/bin/bash
separator="";
#for f in "$@"; do printf %s%q "$separator" "${f}"; separator=$'\n'; done
printf '%q\n' "$@"
#if ((stdin)); then 
#    while read line; do 
#        echo "$line";
#    done
#fi


#    printf 
