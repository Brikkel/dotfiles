#!/bin/bash
# keyboard_brightness_up.sh

current_brightness=$(cat /sys/class/leds/apple::kbd_backlight/brightness)
new_brightness=$((current_brightness + 50))  # Increase by 16 units; adjust as needed

echo $new_brightness | sudo tee /sys/class/leds/apple::kbd_backlight/brightness

