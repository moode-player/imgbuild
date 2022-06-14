#!/usr/bin/bash
#########################################################################
#
# To speed up rebuilds only rebuild stage 3
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

cd $PI_GEN
touch stage0/SKIP
touch stage1/SKIP
touch stage2/SKIP
touch stage2/SKIP_IMAGES
sudo CLEAN=1 ./build.sh 2>&1 |tee ../pi-gen-64-stage3.log
