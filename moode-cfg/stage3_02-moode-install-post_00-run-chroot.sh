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
# r810p: 5.15.32 stock raspberrypi-kernel1:1.20220331-1
# r801: 5.15.28 87c6654a59e0ae6d09869fffceb44c5c698a7d83
# r800: 5.15.23 9e99d81910722b6f2e086f6d14e592f292bcbb8b

# Install kernel from rpi-update
#echo "y" | sudo PRUNE_MODULES=1 rpi-update 87c6654a59e0ae6d09869fffceb44c5c698a7d83

# Install kernel from package
# uname -r| grep 5.15.32
# if [ -n $? ]
# then
    # Expected it to be te current kernel else abort
    # exit 1
    # TODO:
    # Make it more flex then just an abort.
    # Installing kernel like below wouldn't be enough:
    # apt install raspberrypi-kernel1:1.20220331-1
    # Also other kernels should be removed and purged.
    # Will write that code when we actually run in this situation.
# fi

# Install matching kernel drivers
KERNEL_VER=$(basename `ls -d /lib/modules/*-v8+` | sed -r "s/([0-9.]*)[-].*/\1/")
echo "Kernel $KERNEL_VER detected, try to install drivers"
apt-get install -y "aloop-$KERNEL_VER" "pcm1794a-$KERNEL_VER" "ax88179-$KERNEL_VER" "rtl88xxau-$KERNEL_VER"

# Lock important package from upgrades etc
echo "Post moode-player install"
sudo moode-apt-mark hold
