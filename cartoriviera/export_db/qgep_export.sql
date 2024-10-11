-- PGSERVICE=qgep_prod psql -v ON_ERROR_STOP=on -f cartoriviera/export_db/qgep_export.sql

BEGIN;

DROP SCHEMA IF EXISTS usr_cartoriviera CASCADE;
CREATE SCHEMA usr_cartoriviera;

CREATE TABLE usr_cartoriviera.sige_qgis_qgep_reach AS
SELECT *
FROM qgep_od.vw_export_reach;

-- Transform sige_qgis_qgep_reach CompoundCurveZ to MultilineStringZ geometry (TinyOWS for WFS layers for communities does not support CompoundCurveZ)
ALTER TABLE usr_cartoriviera.sige_qgis_qgep_reach ALTER COLUMN progression_geometry TYPE geometry(MultiLineString, 2056)
USING ST_Force2D(ST_Multi(ST_CurveToLine(progression_geometry)));

CREATE INDEX geoidx_sige_qgis_qgep_reach
ON usr_cartoriviera.sige_qgis_qgep_reach
USING gist (progression_geometry);

CREATE TABLE usr_cartoriviera.sige_qgis_qgep_wastewater_structure AS
SELECT *
FROM qgep_od.vw_export_wastewater_structure;

CREATE INDEX geoidx_sige_qgis_qgep_wastewater_structure
ON usr_cartoriviera.sige_qgis_qgep_wastewater_structure
USING gist (situation_geometry);

COMMIT;
