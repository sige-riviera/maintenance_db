#!/bin/bash

# Exit on error
set -e

SRCFOLDERPATH=/home/sitadmin/sit/mount/abonnes

# to show progress, add: --progress
rsync -r -t -v --delete --size-only --omit-dir-times --times -u -s $SRCFOLDERPATH/CROQUIS kandre@cartoriviera.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige/abonnes/
rsync -r -t -v --delete --size-only --omit-dir-times --times -u -s $SRCFOLDERPATH/PHOTOS_ABTS kandre@cartoriviera.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige/abonnes/

# mountpoint -q -- /home/sitadmin/sit/mount/cartoriviera || sshfs kandre@cartoriviera.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige /home/sitadmin/sit/mount/cartoriviera
# chmod -R 755 /home/sitadmin/sit/mount/cartoriviera/abonnes

echo "End of the script file." 1>&2
