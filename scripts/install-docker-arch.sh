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

# Install Docker using yay
execute "yay -S docker" "Installing Docker..."

# Start Docker service
execute "systemctl start docker" "Starting Docker service..."

# Enable Docker service to start on boot
execute "systemctl enable docker" "Enabling Docker service to start on boot..."

# Create docker group if it doesn't already exist
if ! grep -q "^docker:" /etc/group; then
    execute "groupadd docker" "Creating docker group..."
else
    echo "Docker group already exists"
fi

# Add the current user to the docker group
execute "usermod -aG docker $USER" "Adding the current user to the docker group..."

# Install Docker Compose
execute "yay -S docker-compose" "Installing Docker Compose..."

# Notify the user to log out and log back in for the changes to take effect
echo "Please log out and log back in for the changes to take effect."