#!/bin/bash
#db=(/home/e/Documents/irccloud-export-170954-2022-06-18-21-41-18/431968-freenode/*.txt)
db=(/home/e/Documents/*/**.md /home/e/git/http/md/**.md)
#echo grep -h "$@" "${db[@]}"
#echo ------
grep --color -H "$@" /home/e/Documents/*.md /home/e/Documents/**/*.md /home/e/git/http/md/**.md /home/e/firejail/openbox/**/*.md
