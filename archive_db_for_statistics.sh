#!/bin/bash

#set -e 

export PGOPTIONS='--client-min-messages=warning'

currentDay=`date +'%d'`
currentMonth=`date +'%m'`
currentYear=`date +'%Y'`
sourceDB=qwat_prod
archivedDB=qwat_prod_statistics_${currentYear}${currentMonth}${currentDay}
archivedDBforClients=qwat_prod_statistics

# Disconnect users to free databases (before that manually create a copy of production database named qgep_prod_copy)
psql -U sige -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$sourceDB';"

# Create an archived database for statistics
psql -U sige -d postgres -c "CREATE DATABASE $archivedDB WITH TEMPLATE $sourceDB;"

# Drop archived database used by pg_service.conf on clients
psql -U sige -d postgres -c "DROP DATABASE IF EXISTS $archivedDBforClients;"
psql -U sige -d $archivedDB -c "CREATE MATERIALIZED VIEW usr_sige.statistics_metadata AS SELECT CURRENT_DATE AS archived_date,EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER - 1 AS archived_year;"

# Duplicate archived database to be used by pg_service.conf on clients
psql -U sige -d postgres -c "CREATE DATABASE $archivedDBforClients WITH TEMPLATE $archivedDB;"

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
