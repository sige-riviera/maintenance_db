--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_folder.sql

create schema if not exists cartoriviera;

drop table if exists cartoriviera.sige_qgis_qwat_folder;

create table cartoriviera.sige_qgis_qwat_folder as
select * from qwat_od.folder;

alter table cartoriviera.sige_qgis_qwat_folder alter column geometry_line type geometry('MultiLineString', 21781) using st_force2d(st_geomfromewkb(st_fineltra(geometry_line, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')));
alter table cartoriviera.sige_qgis_qwat_folder alter column geometry_polygon type geometry('MultiPolygon', 21781) using st_force2d(st_geomfromewkb(st_fineltra(geometry_polygon, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')));
