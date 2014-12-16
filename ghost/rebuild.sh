#!/bin/bash

set -e

# Update checksums
updpkgsums

# Install package and dependencies
makepkg -cfis

# Start Ghost daemon
echo "Starting Ghost"
sudo systemctl start ghost.service

# Make aurball
mkaurball -f

# Upload to AUR
SRCPKG=$(pacman -Q ghost | tr ' ' -).src.tar.gz
aurupload cyang - network ${SRCPKG}
