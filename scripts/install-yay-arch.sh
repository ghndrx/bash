#!/bin/bash

# Exit if any command fails and treat unset variables as an error
set -eu

# Function to execute a command and print a custom error message if it fails
execute() {
    echo "$2"
    $1
}

# Ensure the script is being run with superuser privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Function to install yay
install_yay() {
    # Check if yay is already installed
    if ! command -v yay &> /dev/null; then
        execute "git clone https://aur.archlinux.org/yay.git" "Cloning yay repository..."
        cd yay
        execute "makepkg -si --noconfirm" "Building and installing yay..."
        cd ..
        execute "rm -rf yay" "Cleaning up..."
    else
        echo "yay is already installed."
    fi

    # Validate installation
    if command -v yay &> /dev/null; then
        echo "yay is installed successfully."
    else
        echo "Failed to install yay."
    fi
}

# Call the function to install yay
install_yay