#!/bin/bash

#set -e

export PGOPTIONS='--client-min-messages=error'

# Update pressure zones attribute on pipes, nodes and valves
psql -U sige -d qwat_prod -c "update qwat_od.pipe set fk_pressurezone = qwat_od.fn_get_pressurezone(geometry)" 1>&2
psql -U sige -d qwat_prod -c "update qwat_od.node set fk_pressurezone = qwat_od.fn_get_pressurezone(geometry)" 1>&2
psql -U sige -d qwat_prod -c "update qwat_od.valve set fk_pressurezone = qwat_od.fn_get_pressurezone(geometry)" 1>&2

# Update district attribute on nodes (suscriber, hydrant, etc.)
#psql -U sige -d qwat_prod -c "update qwat_od.node set fk_district = qwat_od.fn_get_district(geometry)"

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
