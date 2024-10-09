--PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_croquis_reseau.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_protectionzone;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_protectionzone AS
SELECT *
FROM (
    SELECT
        protectionzone.id,
        protectionzone.fk_type,
        protectionzone.name,
        protectionzone.validated,
        protectionzone.date,
        protectionzone.agent,
        protectionzone.geometry,
        protectionzone_type.value_fr AS _type_long,
        protectionzone_type.short_fr AS _type
    FROM qwat_od.protectionzone
    JOIN qwat_vl.protectionzone_type ON protectionzone.fk_type = protectionzone_type.id
) AS foo;
