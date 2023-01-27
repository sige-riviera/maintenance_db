#!/bin/bash

#set -e 

export PGOPTIONS='--client-min-messages=warning'

currentDay=`date +'%d'`
currentMonth=`date +'%m'`
currentYear=`date +'%Y'`
sourceDb=qwat_prod

# Disconnect users to free databases (before that manually create a copy of prod db named qgep_prod_copy)
psql -U sige -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$sourceDb';"

# Create a archived database for statistics on 1st january
if [[ $currentDay=01 && $currentMonth=01 ]]
then
  psql -U sige -d postgres -c "CREATE DATABASE qwat_prod_statistics_${currentYear}${currentMonth}${currentDay} WITH TEMPLATE $sourceDb;"
fi

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
