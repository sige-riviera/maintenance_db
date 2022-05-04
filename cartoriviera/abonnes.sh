#!/bin/bash

# Exit on error
set -e

SRCFOLDERPATH=/home/sitadmin/sit/mount/abonnes
DESTFOLDERPATH=kandre@cartoriviera3.vevey.ch:/var/sig/files/private/sige
SSHKEYFILEPATH=`cat /home/sitadmin/sit/pass/ssh_key_filepath`
#DESTMOUNTFOLDERPATH=/home/sitadmin/sit/mount/cartoriviera_secured

# to show progress, add: --progress
rsync -e "ssh -i $SSHKEYFILEPATH" -r -t -v --delete --size-only --omit-dir-times --times -u -s $SRCFOLDERPATH/CROQUIS $DESTFOLDERPATH/abonnes
rsync -e "ssh -i $SSHKEYFILEPATH" -r -t -v --delete --size-only --omit-dir-times --times -u -s $SRCFOLDERPATH/PHOTOS_ABTS $DESTFOLDERPATH/abonnes

# mountpoint -q -- $DESTMOUNTFOLDERPATH || sshfs $DESTFOLDERPATH $DESTMOUNTFOLDERPATH
# chmod -R 755 $DESTMOUNTFOLDERPATH/abonnes

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
