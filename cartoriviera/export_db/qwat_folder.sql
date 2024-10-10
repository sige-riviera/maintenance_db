--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_folder.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_folder;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_folder AS
SELECT *
FROM qwat_od.folder;

ALTER TABLE usr_cartoriviera.sige_qgis_qwat_folder ALTER COLUMN geometry_line TYPE geometry('MultiLineString', 2056) USING ST_Force2D(geometry_line);
ALTER TABLE usr_cartoriviera.sige_qgis_qwat_folder ALTER COLUMN geometry_polygon TYPE geometry('MultiPolygon', 2056) USING ST_Force2D(geometry_polygon);

CREATE INDEX geoidx_sige_qgis_qwat_folder
ON usr_cartoriviera.sige_qgis_qwat_folder
USING gist (geometry_line);
