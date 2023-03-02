#!/bin/bash
where="$1"
if [[ -z "$where" ]]; then
	echo "usage: s [where] [name]"
	exit 1;
fi
shift

name="$1"
if [[ -z "$name" ]]; then
	echo "usage: s [where] [name]"
exit 1;
fi
shift
find "$where" -type f -name "*${name}*" "$@" 2> /dev/null
