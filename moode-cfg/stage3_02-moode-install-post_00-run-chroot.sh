#!/bin/bash
################################################################################
#
# Install kernel drivers
#
# (C) bitkeeper 2022 http://moodeaudio.org
# License: GPLv3
#
################################################################################

# NOTE: Starting with kernel 6.1.y the custom Allo ASIX ax88179 driver which has
# been unmaintained since mid-2022 is no longer installed due to build breakage
# in the driver. Instead the stock ASIX ax88179 driver is used.

# Use code from rbl_get_kernel_source() for getting kernel version
_KERNEL_VER_FULL=$(uname -r)
KERNEL_PACKAGE=linux-image-$_KERNEL_VER_FULL
KERNEL_PKG_VERSION=`dpkg-query --showformat='${Version}' --show $KERNEL_PACKAGE`
KERNEL_VERSION_PKG_SMALL=$(echo $KERNEL_PKG_VERSION | sed -r "s/[0-9]:([0-9][.][0-9]{1,2}[.][0-9]{1,3})[-].*/\1/")

# Driver install
echo "Kernel $KERNEL_VERSION_PKG_SMALL detected, try to install drivers"
apt-get install -y "aloop-$KERNEL_VERSION_PKG_SMALL" "pcm1794a-$KERNEL_VERSION_PKG_SMALL" "rtl88xxau-$KERNEL_VERSION_PKG_SMALL"
