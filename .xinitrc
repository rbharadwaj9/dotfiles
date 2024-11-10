#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
. /etc/X11/Xsession

setxkbmap -option caps:escape

# Mouse/Trackpad Config
# Use xinput watch-props --device to see all the options that are there and modify them
xinput set-prop "bcm5974" "libinput Natural Scrolling Enabled" 1
