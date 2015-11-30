#!/bin/sh
GEOM='-geom 220x20-0+0'
STRFTIME="%s  %Y-%m-%d %H:%M:%S"
ARGS="${GEOM} -digital -update 5 -strftime \"${STRFTIME}\"" 
eval xclock ${ARGS} &

