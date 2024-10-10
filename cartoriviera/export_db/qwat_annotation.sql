--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_annotation.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_annotation_line;
DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_annotation_point;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_annotation_line AS
SELECT *
FROM qwat_dr.annotationline;

CREATE INDEX geoidx_sige_qgis_qwat_annotation_line
ON usr_cartoriviera.sige_qgis_qwat_annotation_line
USING gist (geometry);

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_annotation_point AS
SELECT *
FROM qwat_dr.annotationpoint;

CREATE INDEX geoidx_sige_qgis_qwat_annotation_point
ON usr_cartoriviera.sige_qgis_qwat_annotation_point
USING gist (geometry);
