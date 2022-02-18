#!/bin/bash
#
# pi-gen-utils project
#
# Copyright (c) 2020, Francis Turner
# All rights reserved.
#
# Copy files from bak subdirectory back into the various pi-gen directories 
# and delete any other files in the pi-gen directory tree that have 
# equivalent files in this directory
#
# Usage: restorepigen.sh [pi-gen-dir]
#
# If a pigen directory is specified on the command line it is used, if not
# then if the environment variable PP is set use that, otherwise assume
# the pi-gen directory is at '../pi-gen'
#
# Note there is very little error checking 
# 

PP=${1-${PP-'../pi-gen'}}

echo "pi-gen directory: $PP"

if [ ! -d $PP ] ; then
    echo Directory '"'$PP'"' does not exist, cannot restore files to it
    exit 1
fi

for F in stage* export*; do
	if [ ! -e $F ] ; then
	    continue
	fi
	D=`echo $F | sed 's/_/\//g' | sed 's!//!_!'`
	if [ -e bak/$F ]; then
		echo "back $F exists, restoring"
		cp -v bak/$F $PP/$D
	else
		echo "no backup $F exists, removing"
		rm -i $PP/$D
	fi
done
