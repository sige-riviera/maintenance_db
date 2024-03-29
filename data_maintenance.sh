#!/bin/bash

set -e 

export PGOPTIONS='--client-min-messages=warning'

psql -U sige -d qwat_prod -c "SELECT qwat_od.fn_update_pipe_crossing()"

psql -U sige -d qwat_prod -c "SELECT qwat_od.fn_node_set_type()"

# psql -d qwat_prod -c "REFRESH MATERIALIZED VIEW qwat_od.vw_pipe_schema_node;"

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
