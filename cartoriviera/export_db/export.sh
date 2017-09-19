#!/bin/bash

set -e

PGSERVICE=sige_commun psql -c "DROP SCHEMA IF EXISTS cartoriviera CASCADE"
PGSERVICE=sige_commun psql -c "CREATE SCHEMA cartoriviera"


# QWAT copy data into dedicated schema
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_hydrant.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_installation.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_meter.sql
PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/qwat_subscriber.sql
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



# Dump qwat.cartoriviera schema
# /usr/bin/pg_dump --host 172.24.171.203 --port 5432 --username "sige" --no-password  --format custom --inserts --column-inserts --verbose --file "/home/rouzaudd/maintenance_db/cartoriviera/export_db/qwat.bakcup" --schema "cartoriviera" "qwat"
/usr/bin/pg_dump --host localhost --port 5432 --username "sige" --no-password  --format custom --verbose --file "/home/sige/maintenance_db/cartoriviera/export_db/qwat.backup" --schema "cartoriviera" "qwat"
# Restore on sige_commun.cartoriviera
/usr/bin/pg_restore --host localhost --port 5432 --username "sige" --dbname "sige_commun" --no-password  --schema cartoriviera --verbose "/home/sige/maintenance_db/cartoriviera/export_db/qwat.backup"


# Also bring stuff from sige_commun in other schemas
PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/maintenance_db/cartoriviera/export_db/distribution_croquis_reseau.sql




# final export
/usr/bin/pg_dump --host localhost --port 5432 --username "sige" --no-password  --format custom --verbose --file "/home/sige/maintenance_db/cartoriviera/export_db/sige.backup" --schema "cartoriviera" "sige_commun"
