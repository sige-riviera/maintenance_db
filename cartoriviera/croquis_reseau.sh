#!/bin/bash

# Exit on error
set -e

SRCFOLDERPATH=/home/sitadmin/sit/mount/reseau
DESTFOLDERPATH=kandre@cartoriviera.vevey.ch:/var/sig/files/private/sige
DESTMOUNTFOLDERPATH=/home/sitadmin/sit/mount/cartoriviera_secured

# to show progress, add: --progress
rsync -r -t -v --delete --size-only --omit-dir-times --times -u -s \
--include=/{,'COMMUNES/'{,'*/'{,Croquis_reseau/{,'**'}}}} --exclude='*' \
$SRCFOLDERPATH/COMMUNES $DESTFOLDERPATH/reseau

# mountpoint -q -- $DESTMOUNTFOLDERPATH || sshfs $DESTFOLDERPATH $DESTMOUNTFOLDERPATH
# chmod -R 755 $DESTMOUNTFOLDERPATH/reseau

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
