#!/bin/bash

# Exit on error
set -e

SRCFOLDERPATH=/home/sitadmin/sit/mount/reseau
DESTFOLDERPATH=kandre@cartoriviera3.vevey.ch:/var/sig/files/private/sige
#DESTMOUNTFOLDERPATH=/home/sitadmin/sit/mount/cartoriviera_secured
SSHKEYFILEPATH=`cat /home/sitadmin/sit/pass/ssh_key_filepath`

# Update data on cartoriviera
# to show progress, add: --progress
rsync -e "ssh -i $SSHKEYFILEPATH" -r -t -v --delete --size-only --omit-dir-times --times -u -s \
--include=/{,'COMMUNES/'{,'*/'{,Croquis_reseau/{,'**'}}}} --exclude='*' \
$SRCFOLDERPATH/COMMUNES $DESTFOLDERPATH/reseau

# Alternative to update data on cartoriviera
# mountpoint -q -- $DESTMOUNTFOLDERPATH || sshfs $DESTFOLDERPATH $DESTMOUNTFOLDERPATH
# chmod -R 755 $DESTMOUNTFOLDERPATH/reseau

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
