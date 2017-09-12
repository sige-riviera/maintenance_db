#!/bin/bash

set -e

PGSERVICE=sige_commun psql -c "DROP SCHEMA IF EXISTS cartoriviera CASCADE"
PGSERVICE=sige_commun psql -c "CREATE SCHEMA cartoriviera"


# QWAT copy data into dedicated schema
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_hydrant.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_installation.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_meter.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_subscriber.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_valve.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_crossing.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_part.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_node.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_pipe.sql



# Dump qwat.cartoriviera schema
# /usr/bin/pg_dump --host 172.24.171.203 --port 5432 --username "sige" --no-password  --format custom --inserts --column-inserts --verbose --file "/home/rouzaudd/maintenance_db/export_cartoriviera/qwat.bakcup" --schema "cartoriviera" "qwat"
/usr/bin/pg_dump --host 172.24.171.203 --port 5432 --username "sige" --no-password  --format custom --verbose --file "/home/sige/maintenance_db/export_cartoriviera/qwat.backup" --schema "cartoriviera" "qwat"
# Restore on sige_commun.cartoriviera
/usr/bin/pg_restore --host 172.24.171.203 --port 5432 --username "sige" --dbname "sige_commun" --no-password  --schema cartoriviera --verbose "/home/sige/maintenance_db/export_cartoriviera/qwat.backup"


# Also bring stuff from sige_commun in other schemas
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/maintenance_db/export_cartoriviera/export_croquis_reseau.sql





/usr/bin/pg_dump --host 172.24.171.203 --port 5432 --username "sige" --no-password  --format custom --verbose --file "/home/sige/maintenance_db/export_cartoriviera/sige.backup" --schema "cartoriviera" "qwat"
