
BEGIN;

CREATE TABLE usr_cartoriviera.sige_qgis_enquete AS SELECT * FROM cadastre.enquete_cadastre;
CREATE TABLE usr_cartoriviera.sige_qgis_enquete_trace AS SELECT * FROM cadastre.enquete_cadastre;

CREATE TABLE usr_cartoriviera.sige_qgis_enquete_camac AS SELECT * FROM cadastre.enquete_camac;
CREATE TABLE usr_cartoriviera.sige_qgis_enquete_vs AS SELECT * FROM cadastre.enquete_camac;

CREATE TABLE usr_cartoriviera.sige_qgis_servitude_ligne AS SELECT * FROM cadastre.vw_servitude_ligne;
CREATE TABLE usr_cartoriviera.sige_qgis_servitude_zone AS SELECT * FROM cadastre.vw_servitude_polygon;

COMMIT;
