--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_folder.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_folder;
drop table if exists usr_cartoriviera.sige_qgis_qwat_folder_mn95;

create table usr_cartoriviera.sige_qgis_qwat_folder_mn95 as
select * from qwat_od.folder;

alter table usr_cartoriviera.sige_qgis_qwat_folder_mn95 alter column geometry_line type geometry('MultiLineString', 2056) using st_force2d(geometry_line);
alter table usr_cartoriviera.sige_qgis_qwat_folder_mn95 alter column geometry_polygon type geometry('MultiPolygon', 2056) using st_force2d(geometry_polygon);

create table usr_cartoriviera.sige_qgis_qwat_folder as select * from usr_cartoriviera.sige_qgis_qwat_folder_mn95;

-- Temporary fix because of null geometries
-- alter table usr_cartoriviera.sige_qgis_qwat_folder alter column geometry_line type geometry('MultiLineString', 21781) using st_geomfromewkb(st_fineltra(geometry_line, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
-- alter table usr_cartoriviera.sige_qgis_qwat_folder alter column geometry_polygon type geometry('MultiPolygon', 21781) using st_geomfromewkb(st_fineltra(geometry_polygon, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
