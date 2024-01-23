#!/bin/bash

# Check if bluez and bluez-utils are installed
if ! command -v bluez &> /dev/null || ! command -v bluez-utils &> /dev/null; then
  echo "Installing bluez and bluez-utils..."
  yay -Syu bluez bluez-utils
fi

# Check if gnome-bluetooth-3.0 is installed
if ! command -v gnome-bluetooth-3.0 &> /dev/null; then
  echo "Installing gnome-bluetooth-3.0..."
  yay -Syu gnome-bluetooth-3.0
fi

# Enable and start bluetooth service
echo "Enabling and starting bluetooth service..."
systemctl enable bluetooth.service
systemctl start bluetooth.service
