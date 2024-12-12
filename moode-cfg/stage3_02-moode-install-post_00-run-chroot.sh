#!/bin/bash
################################################################################
#
# Install kernel drivers
#
# (C) bitkeeper 2022 http://moodeaudio.org
# License: GPLv3
#
################################################################################

#
# aloop     384 kHz patch Ok
# pcm1794a  384 kHz patch Ok
# ax88179   Removed due to breakage in 6.1.yy, unmaintained by vendor (Allo)
# rtl88xxau Removed due to breakage in 6.6.31, unmaintained by Git repo owner
#

# Use code from rbl_get_kernel_source() for getting kernel version
_KERNEL_VER_FULL=$(uname -r)
KERNEL_PACKAGE=linux-image-$_KERNEL_VER_FULL
KERNEL_PKG_VERSION=`dpkg-query --showformat='${Version}' --show $KERNEL_PACKAGE`
KERNEL_VERSION_PKG_SMALL=$(echo $KERNEL_PKG_VERSION | sed -r "s/[0-9]:([0-9][.][0-9]{1,2}[.][0-9]{1,3})[-].*/\1/")

# Driver install
echo "Kernel $KERNEL_VERSION_PKG_SMALL detected, try to install drivers"
apt-get install -y "aloop-$KERNEL_VERSION_PKG_SMALL" "pcm1794a-$KERNEL_VERSION_PKG_SMALL"
