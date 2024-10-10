--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_crossing.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_crossing;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_crossing AS
SELECT *
FROM qwat_od.crossing;

ALTER TABLE usr_cartoriviera.sige_qgis_qwat_crossing ALTER COLUMN geometry TYPE geometry('point', 2056) USING ST_Force2D(geometry);

CREATE INDEX geoidx_sige_qgis_qwat_crossing
ON usr_cartoriviera.sige_qgis_qwat_crossing
USING gist (geometry);
