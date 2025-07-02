#!/bin/bash

#set -e

VERBOSE=no

[[ $VERBOSE =~ yes ]] && VERBOSE_CMD=--verbose
[[ $VERBOSE =~ no ]] && export PGOPTIONS='--client-min-messages=warning'

FOLDERPATH='/home/sitadmin/sit/production/maintenance_db'

PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/fix_pipe_nan_z_coordinates.sql

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
