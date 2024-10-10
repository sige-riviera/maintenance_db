--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_consumptionzone.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_consumptionzone;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_consumptionzone AS
SELECT *
FROM qwat_od.vw_consumptionzone;

CREATE INDEX geoidx_sige_qgis_qwat_consumptionzone
ON usr_cartoriviera.sige_qgis_qwat_consumptionzone
USING gist (geometry);
