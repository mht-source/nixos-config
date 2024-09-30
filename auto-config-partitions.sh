#!/bin/bash

#URL for config file
FILE_URL="https://raw.githubusercontent.com/mht-source/nixos-config/refs/heads/main/disko-config.nix"

# Path for save configuration file from github
DESTINATION_PATH="/root"

# Path to the disko configuration file
DISKO_CONFIG="/root/disko-config.nix"

#File name
FILENAME="disko-config.nix"

# Dowload file to path
echo "Downloading $FILENAME to $DESTINATION_PATH..."
curl -L -o "$DESTINATION_PATH/$FILENAME" "$FILE_URL"

# Check if dowloading completed succesfull
if [$? -eq 0]; then
	echo "$FILENAME downloaded succesfully to $DESTINATION_PATH."
else
	echo "Error downloading file $FILENAME."
	exit 1
fi

# Install required packages if they are not installed
echo "Checking and installing required packages..."

# Install disko
sudo nix-env -iA nixos.disko

# Download disko-config.nix

# Run disko
echo "Running disko..."
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $DISKO_CONFIG

# Check if disko finished successfully
if [ $? -eq 0 ]; then
    echo "Disko completed successfully."
else
    echo "Error occurred during disko execution."
fi
