--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_pressurezone.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_pressurezone;

create table usr_cartoriviera.sige_qgis_qwat_pressurezone as
select * from qwat_od.pressurezone;
