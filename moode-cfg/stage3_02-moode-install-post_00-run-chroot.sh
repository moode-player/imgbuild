#!/bin/bash
################################################################################
# Install kernel drivers and specific package versions here
################################################################################

################################################################################
# Install kernel drivers
# - Kernels > 6.18.29 include aloop and pcm1794a 384K drivers
# - Driver rtl88xxau build fails and has been dropped
################################################################################
# From rbl_get_kernel_source()
_KERNEL_VER_FULL=$(uname -r)
KERNEL_PACKAGE=linux-image-$_KERNEL_VER_FULL
KERNEL_PKG_VERSION=`dpkg-query --showformat='${Version}' --show $KERNEL_PACKAGE`
KERNEL_VERSION_PKG_SMALL=$(echo $KERNEL_PKG_VERSION | sed -r "s/[0-9]:([0-9][.][0-9]{1,2}[.][0-9]{1,3})[-].*/\1/")
# Driver install
#echo "Kernel $KERNEL_VERSION_PKG_SMALL detected: install drivers"
#apt-get install -y \
#	"aloop-$KERNEL_VERSION_PKG_SMALL" \
#	"pcm1794a-$KERNEL_VERSION_PKG_SMALL" \
#	"rtl88xxau-$KERNEL_VERSION_PKG_SMALL"

################################################################################
# Install chromium
# Note: Versions > v130 have issue where scrollbars don't auto-hide
# Tested up to v142 trixie
################################################################################
echo "Chromium: install v126"
apt-get -y install \
	chromium-browser=126.0.6478.164-rpt1 \
	chromium-browser-l10n=126.0.6478.164-rpt1 \
	chromium-codecs-ffmpeg-extra=126.0.6478.164-rpt1 \
	--allow-downgrades
apt-get -y purge chromium chromium-common chromium-l10n chromium-sandbox rpi-chromium-mods
apt-get -y autoremove
echo "Chromium: apply package holds"
apt-mark hold chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra
apt-mark hold chromium chromium-common chromium-l10n chromium-sandbox rpi-chromium-mods

################################################################################
# Install caps
################################################################################
echo "Caps: install 0.9.26-1moode1"
apt-get -y install \
	caps=0.9.26-1moode1 \
	--allow-downgrades
echo "Caps: apply package hold"
apt-mark hold caps

################################################################################
# Install libasound
################################################################################
echo "Libasound: install 1.2.14-1+rpt1moode1"
apt -y install \
	libasound2-dev=1.2.14-1+rpt1moode1 \
	libasound2-data=1.2.14-1+rpt1moode1 \
	libasound2t64=1.2.14-1+rpt1moode1 \
	--allow-downgrades
echo "Libasound: apply package hold"
apt-mark hold libasound2-dev libasound2-data libasound2t64
