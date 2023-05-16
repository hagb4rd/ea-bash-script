#!/bin/bash
separator="";
for f in "$@"; do printf '%s"%s"' "$separator" "${f}"; separator=" "; done

