#!/bin/bash

#set -e

VERBOSE=no

[[ $VERBOSE =~ yes ]] && VERBOSE_CMD=--verbose
[[ $VERBOSE =~ no ]] && export PGOPTIONS='--client-min-messages=warning'

FOLDERPATH='/home/sitadmin/sit/production/maintenance_db'

PGSERVICE=sige_commun psql -c "DROP SCHEMA IF EXISTS cartoriviera CASCADE"
PGSERVICE=sige_commun psql -c "DROP SCHEMA IF EXISTS sige_qgis_cartoriviera CASCADE"
PGSERVICE=sige_commun psql -c "CREATE SCHEMA cartoriviera"

# QWAT copy data into dedicated schema
PGSERVICE=qwat_prod psql -c "DROP SCHEMA IF EXISTS cartoriviera CASCADE"
PGSERVICE=qwat_prod psql -c "CREATE SCHEMA cartoriviera"
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_hydrant.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_installation.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_meter.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_meter_reference.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_subscriber.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_subscriber_reference.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_valve.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_crossing.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_part.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_node.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_pipe.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_remote.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_leak.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_annotation.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_printmap.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_pressurezone.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_consumptionzone.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_folder.sql
PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qwat_protectionzone.sql

# Dump qwat.cartoriviera schema
/usr/bin/pg_dump --host localhost --port 5432 --username "sige" --no-password  --format custom $VERBOSE_CMD --file "$FOLDERPATH/cartoriviera/export_db/qwat.backup" --schema "cartoriviera" "qwat_prod"
# Restore on sige_commun.cartoriviera
/usr/bin/pg_restore --host localhost --port 5432 --username "sige" --dbname "sige_commun" --no-password  --schema cartoriviera $VERBOSE_CMD "$FOLDERPATH/cartoriviera/export_db/qwat.backup"

# QGEP copy data into dedicated schema
PGSERVICE=qgep_prod psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qgep_export.sql
# Dump qgep.cartoriviera schema
/usr/bin/pg_dump --host localhost --port 5432 --username "sige" --format custom $VERBOSE_CMD --file "$FOLDERPATH/cartoriviera/export_db/qgep.backup" --schema "cartoriviera" "qgep_prod"
# Restore on sige_commun.cartoriviera
/usr/bin/pg_restore --host localhost --port 5432 --username "sige" --dbname "sige_commun" --no-password  --schema cartoriviera $VERBOSE_CMD "$FOLDERPATH/cartoriviera/export_db/qgep.backup"
# Create crs:21781 qgep tables by transforming coordinates on sige.commun.cartoriviera
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/qgep_transform.sql

# Also bring stuff from sige_commun in other schemas
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/distribution_croquis_reseau.sql
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/cadastre_sige.sql
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/sige_waterhardness.sql
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/chantier_project.sql

# Rename schema
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -c "ALTER SCHEMA cartoriviera RENAME TO sige_qgis_cartoriviera"
# Add big search table
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/big_search_table.sql
# Transform boolean to oui/non
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/boolean2str.sql
# Set NULL text fields as '-' in identify
# PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f $FOLDERPATH/cartoriviera/export_db/show_null_empty_string.sql


# Final dump
/usr/bin/pg_dump --host localhost --port 5432 --username "sige" --format p $VERBOSE_CMD --file "/home/sitadmin/sit/production/maintenance_db/cartoriviera/export_db/sige.backup" --schema "sige_qgis_cartoriviera" "sige_commun"
# /usr/bin/pg_dump --host localhost --port 5432 --username "sige" --no-password  --format plain $VERBOSE_CMD --file "/home/rouzaudd/Documents/sige.sql" --schema "sige_qgis_cartoriviera" "sige_commun"


# Export
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# FTP UPLOAD
PASS=`cat /home/sitadmin/sit/ftp_pass/carto`
ftp -p -n -v ftp.vevey.ch <<-EOF
user carto_sige $PASS
prompt
binary
cd QGIS_server
put $FOLDERPATH/cartoriviera/export_db/sige.backup sige.backup
bye
EOF

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
