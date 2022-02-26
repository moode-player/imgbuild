#!/bin/bash
#########################################################################
#
# Generate moode audio player image
#
# (C) bitkeeper 2022 http://moodeaudio.org
# License: GPLv3
#
#########################################################################

# kernel hashes for rpi-update
# 5.15.24 77451e601cbee4835b04ccf2d583c53be6e21454
# 5.15.23 9e99d81910722b6f2e086f6d14e592f292bcbb8b
# 5.15.21 fbcab73d5a20f592aa9f6b0e364757ef131dae27

# Install kernel from rpi-update
echo "y" | sudo PRUNE_MODULES=1 rpi-update 9e99d81910722b6f2e086f6d14e592f292bcbb8b

# Install matching kernel drivers
KERNEL_VER=$(basename `ls -d /lib/modules/*-v7l+` | sed -r "s/([0-9.]*)[-].*/\1/")
echo "Kernel $KERNEL_VER detected, try to install drivers"
apt-get install -y "aloop-$KERNEL_VER" "pcm1794a-$KERNEL_VER" "ax88179-$KERNEL_VER" "rtl88xxau-$KERNEL_VER"

# Lock important package from upgrades etc
echo "Post moode-player install"
sudo moode-apt-mark hold
