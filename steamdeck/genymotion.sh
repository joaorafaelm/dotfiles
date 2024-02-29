#!/bin/bash

# Unlock the filesystem
sudo steamos-readonly disable

# Sync the keyring
sudo pacman -S --noconfirm archlinux-keyring

# Initialize pacman's keys with entropy
sudo pacman-key --init

# Setup and populate/load the keys
sudo pacman-key --populate archlinux

# Install all developer packages by default
sudo pacman -S --noconfirm --needed base-devel

# Install Genymotion and its dependencies
yay -Sy --noconfirm genymotion

# Lock the filesystem down again
sudo steamos-readonly enabled

# ARM Translation Packages: https://github.com/m9rco/Genymotion_ARM_Translation
# Aurora Store: https://files.auroraoss.com/AuroraStore/Stable/AuroraStore_4.1.1.apk
