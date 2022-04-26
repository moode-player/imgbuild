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

uname -m | grep "64" > /dev/null
if [[ $? -eq 0 ]]
then
  IS_ARM64=1
fi
echo "$IS_ARM64"

if [ -z "$IS_ARM64" ]
then
    PI_GEN="$ROOT_PATH/pi-gen"
else
    PI_GEN="$ROOT_PATH/pi-gen-64"
fi
PI_GEN_UTILS="$ROOT_PATH/pi-gen-utils"

PI_GEN_CONFIG_DIR="moode-cfg"

# This var is used by pi-gen-utils script as the pi-gen dir
PP=$PI_GEN

function prepare_environment {
    array=( git coreutils quilt parted qemu-user-static debootstrap zerofree zip dosfstools libcap2-bin grep rsync xz-utils file git curl bc libarchive-tools qemu-utils kpartx )
    missing=0
    for i in "${array[@]}"
    do
        dpkg -s $i 2>&1 | grep Status | grep "installed" > /dev/null 2>&1
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

    cat $PI_GEN/build.sh |grep "\-\-allow-downgrades" > /dev/null 2>&1
    if [[ ! $? -eq 0 ]]
    then
        cd $PI_GEN
        patch -p1 < ../pi-gen-allowdowngrades.patch
        cd ..
    fi
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
$PI_GEN_UTILS/setuppigen.sh $PI_GEN

if [ -n "$IS_ARM64" ]
then
    sed -i "s/IMG_NAME[=]\(.*\)/IMG_NAME=\1-arm64/" $PI_GEN/config
fi

# Perform image build
cd $PI_GEN
echo "Starting build:"
sudo ./build.sh
