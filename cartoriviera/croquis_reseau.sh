#!/bin/bash

# Exit on error
set -e

# to show progress, add: --progcrress
rsync -r -t -v --delete --size-only --omit-dir-times --times -u -s \
--include=/{,'COMMUNES/'{,'*/'{,Croquis_reseau/{,'**'}}}} --exclude='*' \
/home/sige/mount/reseau/COMMUNES drouzaud@cartoriviera3.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige/reseau/COMMUNES


chmod -R 755 /home/sige/mount/cartoriviera/reseau
