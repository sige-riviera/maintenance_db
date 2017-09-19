--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_annotation.sql


create schema if not exists cartoriviera;




  drop table if exists cartoriviera.qwat_annotation_line;
  drop table if exists cartoriviera.qwat_annotation_point;

  create table cartoriviera.qwat_annotation_line as
  select * from qwat_dr.annotationline;

  create table cartoriviera.qwat_annotation_point as
  select * from qwat_dr.annotationpoint;

  alter table cartoriviera.qwat_annotation_line alter column geometry type geometry('linestring', 21781) using st_force2d(st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')));
  alter table cartoriviera.qwat_annotation_point alter column geometry type geometry('point', 21781) using st_force2d(st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')));
