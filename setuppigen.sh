#!/bin/bash
#!/bin/bash
#
# pi-gen-utils project
#
# Copyright (c) 2020, Francis Turner
# All rights reserved.
#
# Copy files of the from bak subdirectory back into the various pi-gen directories
# and delete any other files in the pi-gen directory tree that have
# equivalent files in this directory
#
# Usage: setuppigen.sh [pi-gen-dir]
#
# If a pigen directory is specified on the command line it is used, if not
# then if the environment variable PP is set use that, otherwise assume
# the pi-gen directory is at '../pi-gen'
#
# Note there is very little error checking
#

PP=${1-${PP-'../pi-gen'}}

if [ ! -d $PP ] ; then
    echo Directory '"'$PP'"' does not exist, cannot copy files to it
    exit 1
fi

echo "pi-gen directory: $PP"

if [ ! -e bak ] ; then
	mkdir bak
fi
for F in stage* export*; do
	if [ ! -e $F ] ; then
	    continue
	fi
	D=`echo $F | sed 's/_/\//g' | sed 's!//!_!'`
	if [ -e $PP/$D ] ; then
		if [ -e bak/$F ]; then
			echo "Backup $F already present, skipping"
		else
			echo "Backing up $D"
			cp  $PP/$D bak/$F
		fi
	else
		echo "New file $F, skipping backup"
	fi
 	dname=`dirname $PP/$D`
    mkdir -p $dname
	cp $F $PP/$D
done
cp config $PP
