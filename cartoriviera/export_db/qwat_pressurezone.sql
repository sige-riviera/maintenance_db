--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_pressurezone.sql

create schema if not exists cartoriviera;

drop table if exists cartoriviera.sige_qgis_qwat_pressurezone;
drop table if exists cartoriviera.sige_qgis_qwat_pressurezone_mn95;

create table cartoriviera.sige_qgis_qwat_pressurezone_mn95 as
select * from qwat_od.pressurezone;

create table cartoriviera.sige_qgis_qwat_pressurezone as select * from cartoriviera.sige_qgis_qwat_pressurezone_mn95;

alter table cartoriviera.sige_qgis_qwat_pressurezone alter column geometry type geometry('multipolygon', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
