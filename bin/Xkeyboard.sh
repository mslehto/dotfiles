#!/bin/sh
setxkbmap -option
setxkbmap -layout fi,us -option grp:shifts_toggle -option grp_led:scroll -option caps:escape
xmodmap ~/dotfiles/Xmodmap
