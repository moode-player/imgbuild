#!/bin/bash
#
# pi-gen-utils project
#
# Copyright (c) 2020, Francis Turner
# All rights reserved.
#
# Copy files from the various pi-gen directories to the current working directory
#
# Usage: getpigenfile.sh /path/to/pi-gen/stageA/YY/file /path/to/pi-gen/stageB/ZZ/file*
#
# Note there is very little error checking
#

for arg in "$@"
do
  if [ ! -e $arg ]
  then
    echo "WARNING: file $arg does not exist"
  elif [ -d $arg ]
  then
    echo "WARNING: skipping directory $arg, use $arg/* to get files in it"
  else
    target=`echo $arg | sed -e 's!^.*/stage!stage!' -e 's!^.*/export!export!' -e 's!/!_!g'`
    echo "$arg -> $target"
    dname=`dirname $PP/$D`
    mkdir -p $dname
    cp $arg $target
  fi
done
