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

# Function to enable multilib libraries
enable_multilib() {
    # Uncomment the [multilib] section in /etc/pacman.conf
    execute "sed -i '/\[multilib\]/,/Include/s/^#//g' /etc/pacman.conf" "Enabling multilib libraries..."

    # Update the system
    execute "pacman -Sy" "Updating the system..."
}

# Call the function to enable multilib libraries
enable_multilib