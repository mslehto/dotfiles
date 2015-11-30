#!/bin/sh
OS=$(uname -s)
if [ "${OS}" = "OpenBSD" ];then
	uxterm
else
	xterm
fi
