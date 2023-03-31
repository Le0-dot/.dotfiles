#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# General
dunst &
set_random_wallpaper
blueman-applet &
nm-applet &
mpc --port=6606 repeat on
pactl load-module module-switch-on-connect # pipewire-pulseaudio set newly connected devices as default

# Xorg
setxkbmap -layout us,ru -option grp:alt_shift_toggle
kbdd &
xinput --set-prop 'pointer:Logitech G703 LS' 'libinput Accel Speed' -1

exec qtile start
#exec i3
