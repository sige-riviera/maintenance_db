--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_crossing.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_crossing;

create table usr_cartoriviera.sige_qgis_qwat_crossing as
select * from qwat_od.crossing;

alter table usr_cartoriviera.sige_qgis_qwat_crossing alter column geometry type geometry('point', 2056) using st_force2d(geometry);
