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
| sudo -E distro=raspbian codename=bookworm bash

echo "Getting acme.sh repo"

if [ -d "/root/acme.sh" ]; then
  rm -rf /root/acme.sh
fi

wget -O /root/master.zip https://github.com/acmesh-official/acme.sh/archive/refs/heads/master.zip

echo "unzip acme.sh repo"
unzip /root/master.zip -d /root
mv /root/acme.sh-master /root/acme.sh

rm /root/master.zip

echo "Update package lists"
apt-get update
