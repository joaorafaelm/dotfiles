#!/bin/bash

# Allow to write over file system (steam os block)
sudo steamos-readonly disable

# Ensure we have the keys updated
sudo pacman-key --init
sudo pacman-key --populate archlinux

# Install git and base-devel dependencies
sudo pacman -S --needed git base-devel

# Ensure that dependencies get installed correctly (this may be not necessary in some cases)
sudo pacman -S git base-devel
# pacman -S glibc linux-api-headers

git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin
makepkg -si

# Disable again the write over file system
sudo steamos-readonly disable
