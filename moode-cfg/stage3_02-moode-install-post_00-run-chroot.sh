#!/bin/bash
#########################################################################
#
# Generate moode audio player image
#
# (C) bitkeeper 2022 http://moodeaudio.org
# License: GPLv3
#
#########################################################################

# Kernel hashes for rpi-update
# r801: 5.15.28 87c6654a59e0ae6d09869fffceb44c5c698a7d83
# r800: 5.15.23 9e99d81910722b6f2e086f6d14e592f292bcbb8b

# Install kernel from rpi-update
echo "y" | sudo PRUNE_MODULES=1 rpi-update 87c6654a59e0ae6d09869fffceb44c5c698a7d83

# Install matching kernel drivers
KERNEL_VER=$(basename `ls -d /lib/modules/*-v7l+` | sed -r "s/([0-9.]*)[-].*/\1/")
echo "Kernel $KERNEL_VER detected, try to install drivers"
apt-get install -y "aloop-$KERNEL_VER" "pcm1794a-$KERNEL_VER" "ax88179-$KERNEL_VER" "rtl88xxau-$KERNEL_VER"

# Lock important package from upgrades etc
echo "Post moode-player install"
sudo moode-apt-mark hold
