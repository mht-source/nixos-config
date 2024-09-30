#!/bin/bash

# Path to the disko configuration file
DISKO_CONFIG="/root/disko-config.nix"

# Install required packages if they are not installed
echo "Checking and installing required packages..."

# Install disko
sudo nix-env -iA nixos.disko

# Run disko
echo "Running disko..."
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $DISKO_CONFIG

# Check if disko finished successfully
if [ $? -eq 0 ]; then
    echo "Disko completed successfully."
else
    echo "Error occurred during disko execution."
fi
