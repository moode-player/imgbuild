#!/bin/bash
#########################################################################
#
# Generate moode audio player image
#
# (C) bitkeeper 2022 http://moodeaudio.org
# License: GPLv3
#
#########################################################################

# Install matching kernel drivers
# NOTE: Starting with kernel 6.1.y the custom Allo ASIX ax88179 driver is no longer installed
# due to build breakage in the driver which has been unmaintained since mid-2022. Instead the
# stock ASIX ax88179 driver is used.

#TODO: fix driver install
# KERNEL_VER=$(basename `ls -d /lib/modules/*-v8+` | sed -r "s/([0-9.]*)[-].*/\1/")
# echo "Kernel $KERNEL_VER detected, try to install drivers"
# apt-get install -y "aloop-$KERNEL_VER" "pcm1794a-$KERNEL_VER" "rtl88xxau-$KERNEL_VER"

# Lock important package from upgrades etc
echo "Post moode-player install"
#TODO: uncomment moode-apt-mark when moode-player package is also installed
# sudo moode-apt-mark hold
