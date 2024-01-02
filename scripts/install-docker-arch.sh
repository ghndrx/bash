#!/bin/bash

# Function to execute a command and print a custom error message if it fails
execute() {
    echo "$2"
    if ! $1; then
        echo "Error: $3"
        exit 1
    fi
}

# Update the system
execute "sudo pacman -Syu" "Updating the system..." "System update failed"

# Install Docker using yay
execute "yay -S docker" "Installing Docker..." "Docker installation failed"

# Start Docker service
execute "sudo systemctl start docker" "Starting Docker service..." "Starting Docker service failed"

# Enable Docker service to start on boot
execute "sudo systemctl enable docker" "Enabling Docker service to start on boot..." "Enabling Docker service failed"

# Create docker group if it doesn't already exist
if ! grep -q "^docker:" /etc/group; then
    execute "sudo groupadd docker" "Creating docker group..." "Creating docker group failed"
else
    echo "Docker group already exists"
fi

# Add the current user to the docker group
execute "sudo usermod -aG docker $USER" "Adding the current user to the docker group..." "Adding current user to docker group failed"

# Notify the user to log out and log back in for the changes to take effect
echo "Please log out and log back in for the changes to take effect."