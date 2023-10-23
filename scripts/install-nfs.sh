#!/bin/bash

# Default values
SHARE_NAME="nfs_share"
SHARE_PATH="/mnt/nfs_share"
CLIENT_IP="*"
OPTIONS="rw,sync,no_subtree_check"

# Parse command line arguments
while getopts ":n:p:c:o:" opt; do
    case $opt in
        n) SHARE_NAME="$OPTARG"
        ;;
        p) SHARE_PATH="$OPTARG"
        ;;
        c) CLIENT_IP="$OPTARG"
        ;;
        o) OPTIONS="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

# Install NFS server if not already installed
if ! dpkg -s nfs-kernel-server > /dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y nfs-kernel-server
fi

# Create NFS share directory
sudo mkdir -p $SHARE_PATH

# Set permissions on NFS share directory
sudo chown nobody:nogroup $SHARE_PATH
sudo chmod 777 $SHARE_PATH

# Add NFS share to exports file
echo "$SHARE_PATH $CLIENT_IP($OPTIONS)" | sudo tee -a /etc/exports > /dev/null

# Restart NFS server
sudo systemctl restart nfs-kernel-server

echo "NFS share '$SHARE_NAME' created and started with the following options:"
echo "  Path: $SHARE_PATH"
echo "  Client IP: $CLIENT_IP"
echo "  Options: $OPTIONS"
