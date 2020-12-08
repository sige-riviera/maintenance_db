#!/bin/bash

FOLDERPATH='/home/sitadmin/sit/production/maintenance_db'

. $FOLDERPATH/unmount_drives.sh
. $FOLDERPATH/mount_drives.sh

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
