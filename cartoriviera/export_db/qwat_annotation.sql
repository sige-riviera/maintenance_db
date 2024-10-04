--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_annotation.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_annotation_line;
drop table if exists usr_cartoriviera.sige_qgis_qwat_annotation_point;

create table usr_cartoriviera.sige_qgis_qwat_annotation_line as select * from qwat_dr.annotationline;
create table usr_cartoriviera.sige_qgis_qwat_annotation_point as select * from qwat_dr.annotationpoint;
