
BEGIN;

CREATE TABLE usr_cartoriviera.sige_qgis_enquete_mn95 AS SELECT * FROM cadastre.enquete_cadastre;
CREATE TABLE usr_cartoriviera.sige_qgis_enquete_camac_mn95 AS SELECT * FROM cadastre.enquete_camac;
CREATE TABLE usr_cartoriviera.sige_qgis_servitude_ligne_mn95 AS SELECT * FROM cadastre.vw_servitude_ligne;
CREATE TABLE usr_cartoriviera.sige_qgis_servitude_zone_mn95 AS SELECT * FROM cadastre.vw_servitude_polygon;

create table usr_cartoriviera.sige_qgis_enquete as select * from usr_cartoriviera.sige_qgis_enquete_mn95;
create table usr_cartoriviera.sige_qgis_enquete_camac as select * from usr_cartoriviera.sige_qgis_enquete_camac_mn95;
create table usr_cartoriviera.sige_qgis_servitude_ligne as select * from usr_cartoriviera.sige_qgis_servitude_ligne_mn95;
create table usr_cartoriviera.sige_qgis_servitude_zone as select * from usr_cartoriviera.sige_qgis_servitude_zone_mn95;

alter table usr_cartoriviera.sige_qgis_enquete alter column geometry type geometry('linestring', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
alter table usr_cartoriviera.sige_qgis_enquete_camac alter column geometry type geometry('point', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
-- alter table usr_cartoriviera.sige_qgis_servitude_ligne alter column geometry type geometry('multilinestring', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')); -- temporary workaround. See https://github.com/strk/fineltra/issues/10
alter table usr_cartoriviera.sige_qgis_servitude_zone alter column geometry type geometry('multipolygon', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));


COMMIT;
