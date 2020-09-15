#!/bin/bash

. unmount_drives.sh
. mount_drives.sh

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
