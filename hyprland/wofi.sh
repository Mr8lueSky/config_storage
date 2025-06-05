#!/bin/bash
FLAG=/tmp/.wofi.opened
if [ -f $FLAG ]; then
	ps -C wofi | awk 'system("kill -9 " $1)'
	rm $FLAG
else
	touch $FLAG
	wofi --show drun
	rm $FLAG
fi

