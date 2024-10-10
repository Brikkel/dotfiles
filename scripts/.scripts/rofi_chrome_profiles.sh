#!/bin/bash

# Define the Chrome profile options
options="Chrome_personal\nChrome_SUE"

# Combine Chrome profiles and the default run commands
combined=$(echo -e "$options"; compgen -c)

# Use rofi to display the options
selected=$(echo -e "$combined" | rofi -dmenu -p "Run or Open Profile")

# Execute the appropriate action based on the selected option
case "$selected" in
    "Chrome_personal")
        google-chrome --profile-directory="Default" &
        ;;
    "Chrome_SUE")
        google-chrome --profile-directory="Profile 3" &
        ;;
    *)
        # If it's not a Chrome profile, treat it as a regular command
        $selected &
        ;;
esac

