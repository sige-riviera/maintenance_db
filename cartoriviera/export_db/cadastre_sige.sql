
BEGIN;

CREATE TABLE cartoriviera.sige_qgis_enquete AS SELECT * FROM cadastre.enquete_cadastre;
CREATE TABLE cartoriviera.sige_qgis_enquete_camac AS SELECT * FROM cadastre.enquete_camac;
CREATE TABLE cartoriviera.sige_qgis_servitude_ligne AS SELECT * FROM cadastre.vw_servitude_ligne;
CREATE TABLE cartoriviera.sige_qgis_servitude_zone AS SELECT * FROM cadastre.vw_servitude_polygon;

alter table cartoriviera.sige_qgis_enquete alter column geometry type geometry('linestring', 21781) using st_force2d(st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')));
alter table cartoriviera.sige_qgis_enquete_camac alter column geometry type geometry('point', 21781) using st_force2d(st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')));
alter table cartoriviera.sige_qgis_servitude_ligne alter column geometry type geometry('multilinestring', 21781) using st_force2d(st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')));
alter table cartoriviera.sige_qgis_servitude_zone alter column geometry type geometry('multipolygon', 21781) using st_force2d(st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')));


COMMIT;
