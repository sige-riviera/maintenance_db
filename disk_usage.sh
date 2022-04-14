#!/bin/bash

FULL=${1:-simple}

# Exit on error
set -e

# Info about disk space available
diskUsage=$(df -hT /home)
echo "Disk usage and space available on gis server:" 1>&2
echo "$diskUsage" 1>&2
echo

# Check dead.letter file size
fileToCheck=~/dead.letter
fileSizeLimit=10000 # in ko
if [[ -f $fileToCheck ]]
then
  echo "Check $fileToCheck file size:"
  fileInfo=$(ls -lh $fileToCheck)
  echo $fileInfo
  fileSize=$(stat -c "%s" $fileToCheck) # in ko
  if [[ $fileSize -gt $fileSizeLimit ]]
  then
    echo "WARNING: the file $fileToCheck takes a too much disk space."
  fi
else
  echo "File $fileToCheck to be checked does not exist"
fi

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
