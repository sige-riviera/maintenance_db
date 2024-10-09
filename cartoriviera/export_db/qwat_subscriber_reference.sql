--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_subscriber_reference.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_subscriber_reference;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_subscriber_reference AS
SELECT
    subscriber_reference.*,
    vw_export_subscriber.identification AS subscriber_identification,
    vw_export_subscriber.fk_status
FROM qwat_od.subscriber_reference
LEFT JOIN qwat_od.vw_export_subscriber ON subscriber_reference.fk_subscriber = vw_export_subscriber.id;

ALTER TABLE usr_cartoriviera.sige_qgis_qwat_subscriber_reference ALTER COLUMN geometry TYPE geometry('point', 2056) USING ST_Force2D(geometry);
