#!/bin/bash
exec firefox-bin -new-tab 'file:///home/e/git/http/video/index.html#'"$1" > /dev/null 2>&1 &
