#!/bin/bash

# Get the system's hostname to use as part of the SSH key filename
system_name=$(hostname)

# Alternatively, you can ask the user for the system name:
# read -p "Enter the system name: " system_name

# Ask for your email address to associate with the SSH key
read -p "Enter your GitHub email address: " email

# Define the key name
key_name="${system_name}_github"

# Generate the SSH key with the specified name
ssh-keygen -t ed25519 -C "$email" -f "~/.ssh/${key_name}"

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add the SSH private key to the ssh-agent
ssh-add "~/.ssh/${key_name}"

# Install xclip if it's not already installed
if ! command -v xclip &> /dev/null
then
    echo "xclip not found. Installing xclip..."
    sudo dnf install xclip
fi

# Copy the SSH public key to the clipboard
xclip -selection clipboard < "~/.ssh/${key_name}.pub"

# Print a message that the key is in the clipboard
echo "Your SSH key (${key_name}.pub) has been copied to the clipboard. You can now paste it in GitHub."

# Open the GitHub SSH key settings page (optional)
echo "Opening GitHub SSH key settings page..."
xdg-open "https://github.com/settings/keys"

