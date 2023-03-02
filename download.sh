#!/bin/sh
#cat ~/Pictures/girls/todo.txt | #
#while read line
#do
#    --input-file - \
 aria2c \
  --max-concurrent-downloads=2 \
  --always-resume=true \
  --http-accept-gzip=true \
  --retry-wait=15 \
  --max-tries=3 \
  --continue=true \
  --show-files=true \
  --file-allocation='falloc' \
  --max-overall-upload-limit=3K \
  --listen-port=6881 \
  --enable-dht=true \
  --dht-listen-port=6885 \
  --dir=/tmp/shared0/Download
    $*
#done
