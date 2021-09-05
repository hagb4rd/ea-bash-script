#!/bin/sh
#cat ~/Pictures/girls/todo.txt | 
while read line; do wget $line || echo $line; done
