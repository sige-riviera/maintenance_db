BEGIN;

CREATE TABLE usr_cartoriviera.sige_qgis_enquete_trace AS
SELECT *
FROM cadastre.enquete_cadastre;

CREATE INDEX geoidx_sige_qgis_enquete_trace
ON usr_cartoriviera.sige_qgis_enquete_trace
USING gist (geometry);

CREATE TABLE usr_cartoriviera.sige_qgis_enquete_vs AS
SELECT *
FROM cadastre.enquete_camac;

CREATE INDEX geoidx_sige_qgis_enquete_vs
ON usr_cartoriviera.sige_qgis_enquete_vs
USING gist (geometry);

CREATE TABLE usr_cartoriviera.sige_qgis_servitude_ligne AS
SELECT *
FROM cadastre.vw_servitude_ligne;

CREATE INDEX geoidx_sige_qgis_servitude_ligne
ON usr_cartoriviera.sige_qgis_servitude_ligne
USING gist (geometry);

CREATE TABLE usr_cartoriviera.sige_qgis_servitude_zone AS
SELECT *
FROM cadastre.vw_servitude_polygon;

CREATE INDEX geoidx_sige_qgis_servitude_zone
ON usr_cartoriviera.sige_qgis_servitude_zone
USING gist (geometry);

COMMIT;
