#!/bin/sh
GEOM='-geom -0+0'
STRFTIME="%s post epoch  %Y-%m-%d %H:%M:%S"
ARGS="${GEOM} -digital -update 5 -strftime \"${STRFTIME}\"" 
eval xclock ${ARGS} &

