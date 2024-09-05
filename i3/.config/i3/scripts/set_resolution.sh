#!/bin/bash

# xrandr only works in X11 sessions, not Wayland
[ "$XDG_SESSION_TYPE" = x11 ] || exit 0

xrandr --newmode "1440"  106.50  1440 1528 1672 1904  900 903 909 934 -hsync +vsync
xrandr --addmode eDP-1 1440
xrandr --output eDP-1 --mode 1440

feh --bg-fill /home/brikkel/Pictures/Pearl_wallpaper.png
