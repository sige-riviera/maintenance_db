
BEGIN;

CREATE TABLE usr_cartoriviera.sige_qgis_enquete_mn95 AS SELECT * FROM cadastre.enquete_cadastre;
CREATE TABLE usr_cartoriviera.sige_qgis_enquete_trace_mn95 AS SELECT * FROM cadastre.enquete_cadastre;

CREATE TABLE usr_cartoriviera.sige_qgis_enquete_camac_mn95 AS SELECT * FROM cadastre.enquete_camac;
CREATE TABLE usr_cartoriviera.sige_qgis_enquete_vs_mn95 AS SELECT * FROM cadastre.enquete_camac;

CREATE TABLE usr_cartoriviera.sige_qgis_servitude_ligne_mn95 AS SELECT * FROM cadastre.vw_servitude_ligne;
CREATE TABLE usr_cartoriviera.sige_qgis_servitude_zone_mn95 AS SELECT * FROM cadastre.vw_servitude_polygon;

COMMIT;
