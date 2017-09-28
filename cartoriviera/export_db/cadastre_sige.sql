
BEGIN;

CREATE TABLE cartoriviera.sige_qgis_enquete AS SELECT * FROM cadastre.enquete_cadastre;
CREATE TABLE cartoriviera.sige_qgis_servitude_ligne AS SELECT * FROM cadastre.vw_servitude_ligne;
CREATE TABLE cartoriviera.sige_qgis_servitude_zone AS SELECT * FROM cadastre.vw_servitude_polygon;

COMMIT;
