#!/bin/sh

IF=lo0
RANDOMPORT=0
PORT=2620
CLIENTRECONNECTTIME=10
MAXCLIENTS=2
ONCE=--once
TTYD=/usr/local/bin/ttyd
CMD="/usr/local/bin/tmux attach-session -t ttyc"
#CREDENTIAL="--credential user:pass"
INFO=7
NOTICE=6
#DEBUG="--debug $NOTICE"
DEBUG="--debug $INFO"

timestamp()
{
  TIMEFMT="%Y-%m-%dT%H:%M:%S"
  printf $(date +"$TIMEFMT")
}

ARGS="$DEBUG --interface $IF --port $PORT --readonly --reconnect $CLIENTRECONNECTTIME --max-clients $MAXCLIENTS $CREDENTIAL $ONCE $CMD"
printf "$(timestamp) ttyd $ARGS\n"
#LD_LIBRARY_PATH=/home/mslehto/dev/ttyd/libwebsockets/build/lib
$TTYD $ARGS
rc=$?
printf "$(timestamp) ttyd rc=$rc\n\n"

# 2017-09-23
# doas pkg install ttyd
# FreeBSD tempo 11.0-RELEASE-p12 FreeBSD 11.0-RELEASE-p12 #0: Wed Aug  9 10:03:39 UTC 2017     root@amd64-builder.daemonology.net:/usr/obj/usr/src/sys/GENERIC  amd64
#$ ttyd -v
#ttyd version 1.3.2
#ttyd --client-option k=v  --> ttyd: unrecognized option `--client-option'  --> no LISTEN socket
#ttyd -d                   --> silent fail
#ttyd -reaonly             --> RW!

# 2017-09-24
# mkdir ttyd && cd ttyd
# mkdir build && cd build
# cmake .. -DLIBWEBSOCKETS_INCLUDE_DIR="/home/mslehto/dev/ttyd/libwebsockets/build/include" -DLIBWEBSOCKETS_LIBRARIES="/home/mslehto/dev/ttyd/libwebsockets/build/lib"

# cmake .. -DLIBWEBSOCKETS_INCLUDE_DIR="/home/mslehto/dev/ttyd/libwebsockets/build/include" -DLIBWEBSOCKETS_LIBDIR="/home/mslehto/dev/ttyd/libwebsockets/build/lib"

# cmake .. -DLIBWEBSOCKETS_INCLUDEDIR="/home/mslehto/dev/ttyd/libwebsockets/build/include" -DLIBWEBSOCKETS_LIBDIR="/home/mslehto/dev/ttyd/libwebsockets/build/lib"


# LWS
#LWS_IPV6=NO
#LWS_INSTALL_BIN_DIR
#LWS_INSTALL_EXAMPLES_DIR
#LWS_INSTALL_INCLUDE_DIR
#LWS_INSTALL_LIB_DIR
#
#cmake .. -DLWS_WITHOUT_TESTAPPS=ON -DLWS_STATIC_PIC=ON -DLWS_UNIX_SOCK=OFF
#
# make && make install

# LD_LIBRARY_PATH=/home/mslehto/dev/ttyd/libwebsockets/build/lib
# /home/mslehto/dev/ttyd/libwebsockets/build/include

