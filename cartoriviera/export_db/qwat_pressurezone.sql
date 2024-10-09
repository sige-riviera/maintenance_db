--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_pressurezone.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_pressurezone;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_pressurezone AS
SELECT *
FROM qwat_od.pressurezone;
