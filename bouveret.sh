#!/bin/bash

# Exit on error
set -e

export PGCLIENTENCODING=ISO-8859-1
export PGCLIENTENCODING=LATIN1
export box="ST_SetSRID(ST_GeomFromText('POLYGON((2554197.49803597 1138007.59717084,2556720.6652748 1137977.97224944,2556707.85429497 1135687.63992234,2554188.95355474 1135755.39129017,2554197.49803597 1138007.59717084))'),2056)"

TODAY=`date '+%Y%m%d'`
SRCFOLDERPATH=/home/sitadmin/sit/production/data/bouveret

rm -f $SRCFOLDERPATH/*

# Valves
pgsql2shp -h localhost -g geom -f $SRCFOLDERPATH/vannes -u sige qwat_prod "\
SELECT \
 id   AS ID,               \
 identification     AS id_sige,             \
 ST_Force2d(geometry)::geometry(Point,2056) AS geom \
FROM qwat_od.vw_export_valve WHERE ST_Intersects(ST_Force2d(geometry), $box)" 

# Hydrants
pgsql2shp -h localhost -g geom -f $SRCFOLDERPATH/hydrantes -u sige qwat_prod "\
SELECT \
 id   AS ID,               \
 identification    AS id_sige,             \
 ST_Force2d(geometry)::geometry(Point,2056) AS geom \
FROM qwat_od.vw_export_hydrant WHERE status_active IS TRUE AND ST_Intersects(ST_Force2d(geometry), $box)" 


# Pipes
pgsql2shp -h localhost -g geom -f $SRCFOLDERPATH/conduites -u sige qwat_prod "\
SELECT                                         \
 id   AS ID,               \
 ST_Force2d(geometry)::geometry(LineString,2056) AS geom, \
 pipe_material_value_fr   AS MATERIAU,      \
 pipe_function_value_fr        AS FONCTION       \
FROM qwat_od.vw_export_pipe WHERE status_active IS TRUE AND ST_Intersects(ST_Force2d(geometry), $box)"

# Make zip
cd $SRCFOLDERPATH
zip -9r donnees_sige_$TODAY.zip *

#rsync -r -t -v --delete --size-only -u -s $SRCFOLDERPATH/donnees_sige_$TODAY.zip vuadens@46.140.101.173

# Transfert ftp
PASS=`cat /home/sitadmin/sit/production/ftp_pass/bouveret`
ftp -p -n -v miranda.kreativmedia.ch <<-EOF
user vuadens $PASS
prompt
binary
cd donnees_sige
mdelete *.zip
put $SRCFOLDERPATH/donnees_sige_$TODAY.zip donnees_sige_$TODAY.zip
bye
EOF

echo "End of the script file." 1>&2
