#!/bin/bash

# Exit on error
set -e

SRCFOLDERPATH=/home/sitadmin/sit/mount/reseau
DESTFOLDERPATH=/home/sitadmin/sit/mount/cartoriviera

# to show progress, add: --progcrress
rsync -r -t -v --delete --size-only --omit-dir-times --times -u -s \
--include=/{,'COMMUNES/'{,'*/'{,Croquis_reseau/{,'**'}}}} --exclude='*' \
$SRCFOLDERPATH/COMMUNES kandre@cartoriviera.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige/reseau

mountpoint -q -- $DESTFOLDERPATH || sshfs kandre@cartoriviera.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige $DESTFOLDERPATH
# chmod -R 755 $DESTFOLDERPATH/reseau

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
