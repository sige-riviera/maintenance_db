#!/bin/bash

# Exit on error
set -e

export TODAY=`date '+%Y%m%d'`

export OUTPATH=/home/sige/data/bouveret

rm -f $OUTPATH/*


export PGCLIENTENCODING=ISO-8859-1
export PGCLIENTENCODING=LATIN1

export box="ST_SetSRID(ST_GeomFromText('POLYGON((554198.04386628104839474 138007.19270163495093584,556721.11053559719584882 137977.559368270507548,556708.41053558385465294 135687.3260325322044082,554189.57719960552640259 135755.05936593667138368,554198.04386628104839474 138007.19270163495093584))'),21781)"

 # vannes 
pgsql2shp -h localhost -g geom -f $OUTPATH/vannes -u sige qwat "\
SELECT \
 id   AS ID,               \
 identification     AS id_sige,             \
 ST_Force2d(geometry)::geometry(Point,21781) AS geom \
FROM qwat_od.vw_export_valve WHERE ST_Intersects(ST_Force2d(geometry), $box)" 

 # hydrantes 
pgsql2shp -h localhost -g geom -f $OUTPATH/hydrantes -u sige qwat "\
SELECT \
 id   AS ID,               \
 identification    AS id_sige,             \
 ST_Force2d(geometry)::geometry(Point,21781) AS geom \
FROM qwat_od.vw_export_hydrant WHERE status_active IS TRUE AND ST_Intersects(ST_Force2d(geometry), $box)" 


# conduites
pgsql2shp -h localhost -g geom -f $OUTPATH/conduites -u sige qwat "\
SELECT                                         \
 id   AS ID,               \
 ST_Force2d(geometry)::geometry(LineString,21781) AS geom, \
 pipe_material_value_fr   AS MATERIAU,      \
 pipe_function_value_fr        AS FONCTION       \
FROM qwat_od.vw_export_pipe WHERE status_active IS TRUE AND ST_Intersects(ST_Force2d(geometry), $box)"

# make zip
cd $OUTPATH
zip -9r donnees_sige_$TODAY.zip *

#rsync -r -t -v --delete --size-only -u -s $OUTPATH/donnees_sige_$TODAY.zip vuadens@46.140.101.173

# transfert ftp
PASS=`cat /home/sige/ftp_pass/bouveret`
ftp -p -n -v miranda.kreativmedia.ch <<-EOF
user vuadens $PASS
prompt
binary
cd donnees_sige
mdelete *.zip
put $OUTPATH/donnees_sige_$TODAY.zip donnees_sige_$TODAY.zip
bye
EOF

rm -rf $OUTPATH


