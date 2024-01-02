#!/bin/bash

# Exit if any command fails and treat unset variables as an error
set -eu

# Define the source and destination directories
src_dir="$HOME/Desktop"
dst_dir="$HOME/snapshots"

# Ensure the destination directory exists
mkdir -p "$dst_dir"

# Create a snapshot of the source directory
btrfs subvolume snapshot "$src_dir" "$dst_dir/desktop_snapshot_$(date +%Y%m%d%H%M%S)"

#/etc/crontab
# System Reboot takes a snapshot
# @reboot $HOME/snapshots/snapshot.sh
# Every 12 hours take a snapshot
# 0 */12 * * * $HOME/snapshots/snapshot.sh