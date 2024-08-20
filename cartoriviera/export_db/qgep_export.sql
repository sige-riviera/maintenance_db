
BEGIN;

DROP SCHEMA IF EXISTS usr_cartoriviera CASCADE;
CREATE SCHEMA usr_cartoriviera;

CREATE TABLE usr_cartoriviera.sige_qgis_qgep_reach_mn95 AS SELECT * FROM qgep_od.vw_export_reach;
CREATE TABLE usr_cartoriviera.sige_qgis_qgep_wastewater_structure_mn95 AS SELECT * FROM qgep_od.vw_export_wastewater_structure;

-- Transform sige_qgis_qgep_reach_mn95 CompoundCurveZ to MultilineStringZ geometry (TinyOWS for WFS layers for communities does not support CompoundCurveZ)
ALTER TABLE usr_cartoriviera.sige_qgis_qgep_reach_mn95
ALTER COLUMN progression_geometry TYPE geometry(MultiLineStringZ, 2056)
USING ST_Multi(ST_CurveToLine(progression_geometry));

COMMIT;
