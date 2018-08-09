#!/bin/bash

set -e

VERBOSE=no

[[ $VERBOSE =~ yes ]] && VERBOSE_CMD=--verbose
[[ $VERBOSE =~ no ]] && export PGOPTIONS='--client-min-messages=warning'

PGSERVICE=sige_commun psql -c "DROP SCHEMA IF EXISTS cartoriviera CASCADE"
PGSERVICE=sige_commun psql -c "DROP SCHEMA IF EXISTS sige_qgis_cartoriviera CASCADE"
PGSERVICE=sige_commun psql -c "CREATE SCHEMA cartoriviera"


# QWAT copy data into dedicated schema
PGSERVICE=qwat psql -c "DROP SCHEMA IF EXISTS cartoriviera CASCADE"
PGSERVICE=qwat psql -c "CREATE SCHEMA cartoriviera"
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_hydrant.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_installation.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_meter.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_meter_reference.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_subscriber.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_subscriber_reference.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_valve.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_crossing.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_part.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_node.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_pipe.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_remote.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_leak.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_annotation.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_printmap.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_pressurezone.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_consumptionzone.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_folder.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_protectionzone.sql

# Dump qwat.cartoriviera schema
/usr/bin/pg_dump --host localhost --port 5432 --username "sige" --no-password  --format custom $VERBOSE_CMD --file "/home/sige/maintenance_db/cartoriviera/export_db/qwat.backup" --schema "cartoriviera" "qwat"
# Restore on sige_commun.cartoriviera
/usr/bin/pg_restore --host localhost --port 5432 --username "sige" --dbname "sige_commun" --no-password  --schema cartoriviera $VERBOSE_CMD "/home/sige/maintenance_db/cartoriviera/export_db/qwat.backup"

# QGEP copy data into dedicated schema
PGSERVICE=qgep_prod psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qgep_export.sql
# Dump qgep.cartoriviera schema
/usr/bin/pg_dump --host 172.24.173.216 --port 5432 --username "sige" --no-password  --format custom $VERBOSE_CMD --file "/home/sige/maintenance_db/cartoriviera/export_db/qgep.backup" --schema "cartoriviera" "qgep_prod"
# Restore on sige_commun.cartoriviera
/usr/bin/pg_restore --host localhost --port 5432 --username "sige" --dbname "sige_commun" --no-password  --schema cartoriviera $VERBOSE_CMD "/home/sige/maintenance_db/cartoriviera/export_db/qgep.backup"
# transform coordinates on 172.24.171.203
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qgep_transform.sql


# Also bring stuff from sige_commun in other schemas
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/distribution_croquis_reseau.sql
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/cadastre_sige.sql

# rename schema
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -c "ALTER SCHEMA cartoriviera RENAME TO sige_qgis_cartoriviera"
# add big search table
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/big_search_table.sql
# transform boolean to oui/non
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/boolean2str.sql


# final dump
/usr/bin/pg_dump --host localhost --port 5432 --username "sige" --no-password  --format custom $VERBOSE_CMD --file "/home/sige/maintenance_db/cartoriviera/export_db/sige.backup" --schema "sige_qgis_cartoriviera" "sige_commun"
# /usr/bin/pg_dump --host localhost --port 5432 --username "sige" --no-password  --format plain $VERBOSE_CMD --file "/home/rouzaudd/Documents/sige.sql" --schema "sige_qgis_cartoriviera" "sige_commun"



# export
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# FTP UPLOAD
PASS=`cat /home/sige/ftp_pass/carto`
ftp -p -n -v ftp.vevey.ch <<-EOF
user carto_sige $PASS
prompt
binary
cd QGIS_server
put /home/sige/maintenance_db/cartoriviera/export_db/sige.backup sige.backup
bye
EOF
