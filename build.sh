#!/usr/bin/bash
#########################################################################
#
# Generate moode audio player image
#
# (C) bitkeeper 2022 http://moodeaudio.org
# License: GPLv3
#
#########################################################################

ROOT_PATH=`pwd`

echo $ROOT_PATH

PI_GEN="$ROOT_PATH/pi-gen"
PI_GEN_UTILS="$ROOT_PATH/pi-gen-utils"

PI_GEN_CONFIG_DIR="moode-cfg"

# This var is used by pi-gen-utils script as the pi-gen dir
PP=$PI_GEN

function prepare_environment {
    array=( git coreutils quilt parted qemu-user-static debootstrap zerofree zip dosfstools libcap2-bin grep rsync xz-utils file git curl bc libarchive-tools qemu-utils kpartx )
    missing=0
    for i in "${array[@]}"
    do
        dpkg -s $1 2>&1 | grep Status | grep "installed" > /dev/null 2>&1
        if [[ ! $? -eq 0 ]]
        then
            missing=1
            break
        fi

    done

    if [ $missing -eq 1 ]
    then
        sudo apt-get -y install coreutils quilt parted qemu-user-static debootstrap zerofree zip dosfstools libcap2-bin grep rsync xz-utils file git curl bc libarchive-tools qemu-utils kpartx
    fi

    git submodule init
    git submodule update
}

# setup build environment by checkout pi-gen and pi-gen-utils
echo "Prepare environment:"
prepare_environment

# Setup correct config for pi-gen
echo "Set build config:"
cd $PI_GEN_CONFIG_DIR
rm -f $PI_GEN/stage2/EXPORT_NOOBS || true
rm -f $PI_GEN/stage3/EXPORT_NOOBS || true
rm -rf $PI_GEN/stage3/00-install-packages || true
rm -rf $PI_GEN/stage3/01-tweaks || true
$PI_GEN_UTILS/setuppigen.sh

# Perform image build
cd $PI_GEN
echo "Starting build:"
sudo ./build.sh
