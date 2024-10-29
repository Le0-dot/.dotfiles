#!/bin/bash

# A simple script to automate cycling throught the directory of images with swww

# Before running the script make sure that SWWW_TRANSITION, SWWW_TRANSITION_STEP and others mentioned in man swww-img are set properly

dir=""
interval=300

case $# in
    1)
	dir=$1;;
    2)
	dir=$1
	interval=$2;;
    0 | *)
	echo "Usage:
	$0 <DIRECTORY> [INTERVAL=300]"
	exit 1;;
esac

files=$(find $dir/*)

while true; do
    for file in $files; do
	swww img --no-resize "$file"
	sleep $interval
    done
done
