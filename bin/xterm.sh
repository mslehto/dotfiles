#!/bin/sh
OS=$(uname -s)
HOSTNAME=$(hostname -s)
if [ "${OS}" = "OpenBSD" ];then
	uxterm
elif [ "${HOSTNAME}" = "ljb" ];then
	uxterm
else
	xterm
fi
