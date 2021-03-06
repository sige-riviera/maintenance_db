--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_crossing.sql

create schema if not exists cartoriviera;

drop table if exists cartoriviera.sige_qgis_qwat_crossing;
drop table if exists cartoriviera.sige_qgis_qwat_crossing_mn95;

create table cartoriviera.sige_qgis_qwat_crossing_mn95 as
select * from qwat_od.crossing;

alter table cartoriviera.sige_qgis_qwat_crossing_mn95 alter column geometry type geometry('point', 2056) using st_force2d(geometry);

create table cartoriviera.sige_qgis_qwat_crossing as select * from cartoriviera.sige_qgis_qwat_crossing_mn95;

alter table cartoriviera.sige_qgis_qwat_crossing alter column geometry type geometry('point', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
