#!/bin/bash
i=1
if [[ $i gt; 0 ]] (
	echo $i;
	wait 5;
)
