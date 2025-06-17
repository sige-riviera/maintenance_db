#!/bin/bash

set -e 

export PGOPTIONS='--client-min-messages=warning'

psql -U sige -d sige_commun -c "DELETE FROM cadastre.servitude_dessin WHERE last_modified < now() - interval '1 year';"

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
