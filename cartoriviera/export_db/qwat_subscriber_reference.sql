--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_subscriber_reference.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_subscriber_reference;

create table usr_cartoriviera.sige_qgis_qwat_subscriber_reference as
select subscriber_reference.*, vw_export_subscriber.identification as subscriber_identification, vw_export_subscriber.fk_status from qwat_od.subscriber_reference
	left join qwat_od.vw_export_subscriber ON subscriber_reference.fk_subscriber = vw_export_subscriber.id;

alter table usr_cartoriviera.sige_qgis_qwat_subscriber_reference alter column geometry type geometry('point', 2056) using st_force2d(geometry);
