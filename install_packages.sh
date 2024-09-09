#!/bin/bash

# Common programs to install on all supported distributions
common_programs=("git" "curl" "neovim")

# Distro-specific programs
ubuntu_programs=("i3")
macos_programs=("wget") 
fedora_programs=("i3" "dnf-plugins-core")

install_ubuntu() {
    echo "Detected Ubuntu. Installing Ubuntu-specific programs: ${ubuntu_programs[*]}"
    sudo apt update
    sudo apt install -y "${common_programs[@]}"
    sudo apt install -y "${ubuntu_programs[@]}"
}

# Function to install distro-specific programs on macOS
install_macos() {
    echo "Detected macOS. Installing macOS-specific programs: ${macos_programs[*]}"
    # Check if Homebrew is installed, install it if not
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found, installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew update
    brew install "${common_programs[@]}"
    brew install "${macos_programs[@]}"
}

# Function to install distro-specific programs on Fedora
install_fedora() {
    echo "Detected Fedora. Installing Fedora-specific programs: ${fedora_programs[*]}"
    sudo dnf upgrade --refresh -y
    sudo dnf install -y "${common_programs[@]}"
    sudo dnf install -y "${fedora_programs[@]}"
}

# Check the OS and call the appropriate functions
if [ -f /etc/os-release ]; then
    # For Linux distributions
    . /etc/os-release
    case "$ID" in
        ubuntu)
            install_ubuntu
            ;;
        fedora)
            install_fedora
            ;;
        *)
            echo "Unsupported Linux distribution: $ID"
            ;;
    esac
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # For macOS
    install_macos
else
    echo "Unsupported operating system: $OSTYPE"
fi


