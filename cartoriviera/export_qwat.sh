#!/bin/bash

# Exit on error
set -e

export db_address=localhost
export sqliteoutput=/home/sige/data_carto/sige_qwat.sqlite
export dbqwat=qwat
export dbcommun=sige_commun

#export PGCLIENTENCODING=LATIN1;

rm $sqliteoutput


########################################################################
# TABLES AND VIEWS

echo "camac"
ogr2ogr -sql "SELECT * FROM cadastre.enquete_camac"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln enquete_camac -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbcommun' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

ogr2ogr -sql "SELECT * FROM cadastre.enquete_cadastre"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln enquete_cadastre -nlt LINESTRING -progress -preserve_fid \
PG:"dbname='$dbcommun' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

ogr2ogr -sql "SELECT * FROM cadastre.vw_servitude_ligne"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln servitude_ligne -nlt MULTILINESTRING -progress -preserve_fid \
PG:"dbname='$dbcommun' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

ogr2ogr -sql "SELECT * FROM cadastre.vw_servitude_polygon"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln servitude_poylgon -nlt MULTIPOLYGON -progress -preserve_fid \
PG:"dbname='$dbcommun' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

##########################################################################
# QWAT

echo "search view"
ogr2ogr -sql "SELECT * FROM qwat_od.vw_search_view 
UNION 
SELECT *
FROM dblink('dbname=sige_commun',\$\$SELECT 'Adresse Valais' AS layer_name, rue || ' ' || numero || ', ' || commune AS search_text, geometry FROM adresse.geopost WHERE commune = 'Bouveret' OR commune = 'Les Evouettes'\$\$)
AS addr(layer_name varchar(120), search_text varchar(120), geometry geometry(Point,21781))" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln search_view -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "pipes"
ogr2ogr -sql "SELECT * FROM qwat_od.vw_pipe"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln pipe -nlt LINESTRING -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "pipe schema"
ogr2ogr -sql "SELECT * FROM qwat_od.vw_pipe_schema"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln pipe_schema -nlt LINESTRING -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "nodes"
ogr2ogr -sql "SELECT * FROM qwat_od.node WHERE _under_object IS FALSE"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln node -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "parts"
ogr2ogr -sql "SELECT * FROM qwat_od.part "  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln part -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "valves"
ogr2ogr -sql "SELECT * FROM qwat_od.vw_valve "  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln valve -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "hydrants"
ogr2ogr -sql "SELECT * FROM qwat_od.vw_hydrant WHERE fk_distributor = 1"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln hydrant -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "pressure zones"
ogr2ogr -sql "SELECT * FROM qwat_od.pressurezone" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln pressurezone -nlt POLYGON -progress \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "print maps"
ogr2ogr -sql "SELECT * FROM qwat_od.vw_printmap" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln printmap -nlt MULTIPOLYGON -progress \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "meter"
ogr2ogr -sql "SELECT * FROM qwat_od.meter;"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln meter -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "subscriber"
ogr2ogr -sql "SELECT vw_subscriber.*, '<a href=javascript:app.openInfoWindow(\"http://www.cartoriviera.ch/sige/www/gallery.php?type=abonne&abonne='
||identification||'&commune='||district.prefix||
'\",\"Abonne\",600,600)>croquis</a>' as links 
FROM qwat_od.vw_subscriber
LEFT OUTER JOIN qwat_od.district ON vw_subscriber.fk_district = district.id;"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln subscriber -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "subscriber_reference"
ogr2ogr -sql "SELECT subscriber_reference.id, subscriber.identification, subscriber_reference.geometry::geometry(Point,21781)
FROM qwat_od.subscriber JOIN qwat_od.subscriber_reference 
ON subscriber.id = subscriber_reference.fk_subscriber;" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln subscriber_reference -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "protections zone"
ogr2ogr -sql "SELECT * FROM qwat_od.vw_protectionzone"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln protectionzone -nlt MULTIPOLYGON -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "leaks"
ogr2ogr -sql "SELECT * FROM qwat_od.vw_leak"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln leak -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "telecommande"
ogr2ogr -sql "SELECT * FROM qwat_od.vw_remote"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln telecommande -nlt MULTILINESTRING -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

##########################################################################
# INSTALLATION

echo "installation tank"
ogr2ogr -sql "SELECT *, '<a href=javascript:app.openInfoWindow(\"http://www.cartoriviera.ch/sige/www/gallery.php?type=ouvrage&ouvrage='||identification||
'\",\"Ouvrage\",600,600)>croquis</a>' as links FROM qwat_od.vw_installation_tank_fr WHERE fk_status in (1301,1302)" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln installation_tank -nlt POINT -progress \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536
echo "installation pump"
ogr2ogr -sql "SELECT *, '<a href=javascript:app.openInfoWindow(\"http://www.cartoriviera.ch/sige/www/gallery.php?type=ouvrage&ouvrage='||identification||
'\",\"Ouvrage\",600,600)>croquis</a>' as links FROM qwat_od.vw_installation_pump_fr WHERE fk_status in (1301,1302)" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln installation_pump -nlt POINT -progress \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536
echo "installation source"
ogr2ogr -sql "SELECT *, '<a href=javascript:app.openInfoWindow(\"http://www.cartoriviera.ch/sige/www/gallery.php?type=ouvrage&ouvrage='||identification||
'\",\"Ouvrage\",600,600)>croquis</a>' as links FROM qwat_od.vw_installation_source_fr WHERE fk_status in (1301,1302)" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln installation_source -nlt POINT -progress \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536
echo "installation treatment"
ogr2ogr -sql "SELECT *, '<a href=javascript:app.openInfoWindow(\"http://www.cartoriviera.ch/sige/www/gallery.php?type=ouvrage&ouvrage='||identification||
'\",\"Ouvrage\",600,600)>croquis</a>' as links FROM qwat_od.vw_installation_treatment_fr WHERE fk_status in (1301,1302)" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln installation_treatment -nlt POINT -progress \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536
echo "installation pressurecontrol"
ogr2ogr -sql "SELECT *, '<a href=javascript:app.openInfoWindow(\"http://www.cartoriviera.ch/sige/www/gallery.php?type=ouvrage&ouvrage='||identification||
'\",\"Ouvrage\",600,600)>croquis</a>' as links FROM qwat_od.vw_installation_pressurecontrol_fr WHERE fk_status in (1301,1302)" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln installation_pressurecontrol -nlt POINT -progress \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536
echo "installation chamber"
ogr2ogr -sql "SELECT *, '<a href=javascript:app.openInfoWindow(\"http://www.cartoriviera.ch/sige/www/gallery.php?type=ouvrage&ouvrage='||identification||
'\",\"Ouvrage\",600,600)>croquis</a>' as links FROM qwat_od.vw_installation_chamber_fr WHERE fk_status in (1301,1302)" \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln installation_valvechamber -nlt POINT -progress \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

##########################################################################
# DRAWING

echo "dimensions distance"
ogr2ogr -sql "SELECT * FROM qwat_dr.dimension_distance"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln dimension_distance -nlt LINESTRING -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536
echo "dimensions orientation"
ogr2ogr -sql "SELECT * FROM qwat_dr.dimension_orientation"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln dimension_orientation -nlt LINESTRING -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536

echo "annotation point"
ogr2ogr -sql "SELECT * FROM qwat_dr.annotationpoint"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln annotationpoint -nlt POINT -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536
echo "annotation ligne"
ogr2ogr -sql "SELECT * FROM qwat_dr.annotationline"  \
-overwrite -a_srs EPSG:21781 -f SQLite $sqliteoutput \
-nln annotationline -nlt LINESTRING -progress -preserve_fid \
PG:"dbname='$dbqwat' host=$db_address port='5432' user='sige'" \
-dsco SPATIALITE=no -lco "SPATIAL_INDEX=no FORMAT=SPATIALITE" -gt 65536



########################################################################
# FTP UPLOAD
PASS=`cat ../ftp_pass/carto`
ftp -n -v ftp.vevey.ch <<-EOF
user carto_sige $PASS 
prompt
binary
cd Distribution
put $sqliteoutput sige_distribution_v7.sqlite
bye
EOF

