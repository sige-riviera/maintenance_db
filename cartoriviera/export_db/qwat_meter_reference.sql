--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_meter_reference.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_meter_reference;
drop table if exists usr_cartoriviera.sige_qgis_qwat_meter_reference_mn95;

create table usr_cartoriviera.sige_qgis_qwat_meter_reference_mn95 as
select meter_reference.*, vw_export_meter.identification as meter_identification from qwat_od.meter_reference
	left join qwat_od.vw_export_meter ON meter_reference.fk_meter = vw_export_meter.id;

alter table usr_cartoriviera.sige_qgis_qwat_meter_reference_mn95 alter column geometry type geometry('point', 2056) using st_force2d(geometry);

create table usr_cartoriviera.sige_qgis_qwat_meter_reference as select * from usr_cartoriviera.sige_qgis_qwat_meter_reference_mn95;

alter table usr_cartoriviera.sige_qgis_qwat_meter_reference alter column geometry type geometry('point', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
