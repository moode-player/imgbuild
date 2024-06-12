#!/bin/bash
################################################################################
#
# Install kernel drivers
#
# (C) bitkeeper 2022 http://moodeaudio.org
# License: GPLv3
#
################################################################################

KERNEL_VER="6.6.28"
apt-get install -y "aloop-$KERNEL_VER" "pcm1794a-$KERNEL_VER" "rtl88xxau-$KERNEL_VER"
