#!/bin/sh
setxkbmap -option
setxkbmap -layout fi,us -option grp:alt_caps_toggle
xmodmap ~/dotfiles/Xmodmap
