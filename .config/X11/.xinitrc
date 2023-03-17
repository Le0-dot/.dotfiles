#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

random_wallpaperd &
dunst &
setxkbmap -layout us,ru -option grp:alt_shift_toggle
mpc --port=6606 repeat on
blueman-applet &
kbdd &

exec qtile start
#exec i3
