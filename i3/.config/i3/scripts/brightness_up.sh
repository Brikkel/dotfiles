#!/bin/bash
# increase_brightness.sh

current_brightness=$(xrandr --verbose | grep -A5 'eDP-1' | grep -m 1 -i brightness | cut -f2 -d ' ')
new_brightness=$(echo "$current_brightness + 0.10" | bc)

xrandr --output eDP-1 --brightness $new_brightness

