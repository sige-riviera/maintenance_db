#!/bin/bash

# Exit on error
set -e

# Info about disk space available
diskUsage=$(df -hT /home)
echo "*** Disk usage and space available on gis server: ***" 1>&2
echo "$diskUsage" 1>&2
echo "" 1>&2

# Check dead.letter file size
fileToCheck=/root/dead.letter
fileSizeLimit=10 # in Mo
echo "*** Check if $fileToCheck file size is too large: ***" 1>&2
echo ""
if [[ -f $fileToCheck ]]
then
  fileSize=$(stat -c "%s" $fileToCheck) # in bytes
  fileSizeInMB=$(echo "scale=2; $fileSize/1024/1024" | bc) # in Mb
  echo "dead.letter file size is: $fileSizeInMB Mb" 1>&2
  if (( $(echo "$fileSizeInMB > $fileSizeLimit" | bc -l) ))
  then
    echo "WARNING: the file $fileToCheck takes too much disk space" 1>&2
  fi
else
  echo "File $fileToCheck does not exist" 1>&2
fi
echo "" 1>&2

# Check ouvrage data processing folder size
echo "*** Ouvrage data processing folder size: ***" 1>&2
du -sh /home/sitadmin/sit/production/data/carto/data_ouvrage/ 1>&2
echo "" 1>&2

# List 25 largest files and directories
echo "*** Largest files and directories: ***" 1>&2
du /home/sitadmin/ -ch -S --exclude=/home/sitadmin/sit/mount 2>&1 | grep -v 'denied' | sort -rh | head -25 1>&2
echo "" 1>&2

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
