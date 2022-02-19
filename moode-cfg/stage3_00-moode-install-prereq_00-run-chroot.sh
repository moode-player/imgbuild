#!/bin/bash
# echo "Installing cloudsmith repository"

# Normal install will not work due Warning: apt-key is deprecated:
# curl -1sLf \
# 'https://dl.cloudsmith.io/public/moodeaudio/m8y/setup.deb.sh' \
# | sudo -E bash

# Using gpg --dearmor instead
# KEYRING=/usr/share/keyrings/moodeaudio_m8y.gpg
curl -fsSL 'https://dl.cloudsmith.io/public/moodeaudio/m8y/gpg.E5A251A46C58117E.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/E5A251A46C58117E.gpg > /dev/null
curl -fsSL 'https://dl.cloudsmith.io/public/moodeaudio/m8y/config.deb.txt?distro=raspbian&codename=bullseye' > /etc/apt/sources.list.d/moodeaudio-m8y.list

echo "Update package lists"
apt-get update

