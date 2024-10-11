-- PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f cartoriviera/export_db/qwat_meter_reference.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_meter_reference;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_meter_reference AS
SELECT
    meter_reference.*,
    vw_export_meter.identification AS meter_identification
FROM qwat_od.meter_reference 
LEFT JOIN qwat_od.vw_export_meter
ON meter_reference.fk_meter = vw_export_meter.id;

ALTER TABLE usr_cartoriviera.sige_qgis_qwat_meter_reference ALTER COLUMN geometry TYPE geometry('point', 2056) USING ST_Force2D(geometry);

CREATE INDEX geoidx_sige_qgis_qwat_meter_reference
ON usr_cartoriviera.sige_qgis_qwat_meter_reference
USING gist (geometry);
