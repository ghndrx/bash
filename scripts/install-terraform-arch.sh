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

# Update the system
execute "pacman -Syu" "Updating the system..."

# Install Terraform using yay
execute "yay -S terraform" "Installing Terraform..."

echo "Terraform installation completed successfully."