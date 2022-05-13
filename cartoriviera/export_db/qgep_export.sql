
BEGIN;

DROP SCHEMA IF EXISTS usr_cartoriviera CASCADE;
CREATE SCHEMA usr_cartoriviera;

CREATE TABLE usr_cartoriviera.sige_qgis_qgep_reach_mn95 AS SELECT * FROM qgep_od.vw_export_reach;
CREATE TABLE usr_cartoriviera.sige_qgis_qgep_wastewater_structure_mn95 AS SELECT * FROM qgep_od.vw_export_wastewater_structure;

COMMIT;
