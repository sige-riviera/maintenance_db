-- PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f cartoriviera/export_db/sige_waterhardness.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_waterhardness;

CREATE TABLE usr_cartoriviera.sige_qgis_waterhardness AS
SELECT
    id,
    name AS sqwh_name,
    hardness_median AS sqwh_hardness_median,
    hardness_min AS sqwh_hardness_min,
    hardness_max AS sqwh_hardness_max,
    classification AS sqwh_classification,
    appreciation AS sqwh_appreciation,
    geometry
FROM sige.waterhardness
WHERE visible IS TRUE;

CREATE INDEX geoidx_sige_qgis_waterhardness
ON usr_cartoriviera.sige_qgis_waterhardness
USING gist (geometry);
