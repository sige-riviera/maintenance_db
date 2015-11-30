#!/bin/bash

# Exit on error
set -e

# to show progress, add: --progress
rsync -r -t -v --delete --size-only -u -s /home/sige/mount/dao_saisie/ABONNES/CROQUIS drouzaud@cartoriviera3.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige/abonnes/
rsync -r -t -v --delete --size-only -u -s /home/sige/mount/dao_saisie/ABONNES/PHOTOS_ABTS drouzaud@cartoriviera3.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige/abonnes/
#chmod -R 755 /home/sige/mount/cartoriviera/abonnes
