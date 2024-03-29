--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_consumptionzone.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_consumptionzone;
drop table if exists usr_cartoriviera.sige_qgis_qwat_consumptionzone_mn95;

create table usr_cartoriviera.sige_qgis_qwat_consumptionzone_mn95 as
select * from qwat_od.vw_consumptionzone;

create table usr_cartoriviera.sige_qgis_qwat_consumptionzone as select * from usr_cartoriviera.sige_qgis_qwat_consumptionzone_mn95;

alter table usr_cartoriviera.sige_qgis_qwat_consumptionzone alter column geometry type geometry('multipolygon', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
