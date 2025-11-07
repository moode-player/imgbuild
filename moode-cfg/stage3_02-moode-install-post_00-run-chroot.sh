#!/bin/bash
################################################################################
#
# Post moode install
#
# Install kernel drivers
# - aloop     384 kHz patch Ok
# - pcm1794a  384 kHz patch Ok
# - ax88179   Removed due to breakage in 6.1.yy, unmaintained by vendor (Allo)
# - rtl88xxau Removed due to breakage in 6.6.31, unmaintained by Git repo owner
#
# Downgrade chromium
# - Install version 126.0.6478.164-rpt1
# - Apply package holds so downstream processes don't install newer chromium
#
# (C) 2022 @bitkeeper http://moodeaudio.org
# (C) 2024 The moOde audio player project / Tim Curtis
# License: GPLv3
#
################################################################################

################################################################################
# Install kernel drivers
################################################################################

# Use code from rbl_get_kernel_source() for getting kernel version
_KERNEL_VER_FULL=$(uname -r)
KERNEL_PACKAGE=linux-image-$_KERNEL_VER_FULL
KERNEL_PKG_VERSION=`dpkg-query --showformat='${Version}' --show $KERNEL_PACKAGE`
KERNEL_VERSION_PKG_SMALL=$(echo $KERNEL_PKG_VERSION | sed -r "s/[0-9]:([0-9][.][0-9]{1,2}[.][0-9]{1,3})[-].*/\1/")

# Driver install
echo "Kernel $KERNEL_VERSION_PKG_SMALL detected, try to install drivers"
apt-get install -y "pcm1794a-$KERNEL_VERSION_PKG_SMALL" "rtl88xxau-$KERNEL_VERSION_PKG_SMALL"

################################################################################
# Install specific version of chromium if needed
################################################################################

#echo "Chromium, install v126"
#apt-get -y install chromium-browser=126.0.6478.164-rpt1 chromium-browser-l10n=126.0.6478.164-rpt1 chromium-codecs-ffmpeg-extra=126.0.6478.164-rpt1 --allow-downgrades
#apt-get -y purge chromium chromium-common chromium-sandbox rpi-chromium-mods
#apt-get -y autoremove
#echo "Chromium, apply package holds"
#apt-mark hold chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra
#apt-mark hold chromium chromium-common chromium-sandbox rpi-chromium-mods
