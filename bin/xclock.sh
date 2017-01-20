#!/bin/sh
HOST=$(hostname -s)
GEOM='-geom 260x25-0+0'
if [ $HOST = "spof" ] ; then
	GEOM='-geom 280x25+3550+1050'
fi
STRFTIME="%s  %Y-%m-%d %H:%M:%S"
ARGS="${GEOM} -digital -update 5 -strftime \"${STRFTIME}\"" 
eval xclock ${ARGS} &

