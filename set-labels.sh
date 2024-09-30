#!/bin/bash

# Path to the disko configuration file
DISKO_CONFIG="/root/disko-config.nix"

# Install required packages if they are not installed
echo "Checking and installing required packages..."

# Install dosfstools (for fatlabel) and e2fsprogs (for e2label)
sudo nix-env -iA nixos.dosfstools nixos.e2fsprogs

# Run disko
echo "Running disko..."
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko $DISKO_CONFIG

# Check if disko finished successfully
if [ $? -eq 0 ]; then
    echo "Disko completed successfully."

    # Unmount root partition before setting label
    echo "Unmounting root partition..."
    sudo umount -l /dev/sda3

    # Set label for ROOT partition
    echo "Setting label for ROOT partition..."
    sudo e2label /dev/sda3 nixos

    #SWAP partition: Disable swap, set label and enable swap
    echo "Turning off swap..."
    sudo swapoff /dev/sda2

    # Remount the root partition
    echo "Mounting root partition..."
    sudo mount /dev/sda3 /mnt

    # SWAP partition: Initialize swap and set label
    echo "Setting label for SWAP partition..."
    sudo mkswap -L swap /dev/sda2
    sudo swapon /dev/sda2	


    # EFI partition: Set label without formatting
    echo "Setting label for EFI partition..."
    sudo fatlabel /dev/sda1 boot

    echo "Labels have been successfully assigned."
else
    echo "Error occurred during disko execution."
fi
