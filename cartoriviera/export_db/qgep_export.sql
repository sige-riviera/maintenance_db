
BEGIN;

DROP SCHEMA IF EXISTS cartoriviera CASCADE;
CREATE SCHEMA cartoriviera;

CREATE TABLE cartoriviera.sige_qgis_qgep_reach_mn95 AS SELECT * FROM qgep_export.vw_export_reach;
CREATE TABLE cartoriviera.sige_qgis_qgep_wastewater_structure_mn95 AS SELECT * FROM qgep_export.vw_export_wastewater_structure;

COMMIT;
