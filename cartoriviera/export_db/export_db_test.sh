#!/bin/bash

#set -e

VERBOSE=no

[[ $VERBOSE =~ yes ]] && VERBOSE_CMD=--verbose
[[ $VERBOSE =~ no ]] && export PGOPTIONS='--client-min-messages=warning'

FOLDERPATH='/home/sitadmin/sit/production/maintenance_db'

# Export
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# FTP UPLOAD
PASS=`cat /home/sitadmin/sit/ftp_pass/carto`
ftp -p -n -v ftp.vevey.ch <<-EOF
user carto_sige $PASS
prompt
binary
cd QGIS_server
rename sige.backup sige_previous.backup
put $FOLDERPATH/cartoriviera/export_db/sige.backup sige.backup
bye
EOF

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
