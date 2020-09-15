#!/bin/bash

# Test regular database operation
psql -d postgres -c "SELECT version();" 1>&2
psql -d postgres -c "SELECT PostGIS_full_version();" 1>&2

# Test stdout (1) / Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi

# Test stderr (2)
#mkdir /home/sitadmin/thisdirectorydoesnotexists/test


