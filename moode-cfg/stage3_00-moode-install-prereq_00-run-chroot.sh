#!/bin/bash
#########################################################################
#
# Generate moode audio player image
#
# (C) bitkeeper 2022 http://moodeaudio.org
# License: GPLv3
#
#########################################################################

echo "Installing cloudsmith repository"

curl -1sLf \
'https://dl.cloudsmith.io/public/moodeaudio/m8y/setup.deb.sh' \
| sudo -E distro=raspbian codename=trixie component=unstable bash

echo "Update package lists"
apt-get update
