#!/bin/bash

# Test regular database operation
psql -d postgres -c "SELECT version();" 1>&2
psql -d postgres -c "SELECT PostGIS_full_version();" 1>&2

# Test stdout (1)
echo "Testing cron job" 1>&2

# Test stderr (2)
#mkdir /home/sitadmin/thisdirectorydoesnotexists/test

