--PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_waterhardness.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_waterhardness;

create table usr_cartoriviera.sige_qgis_waterhardness as
select id, name AS sqwh_name, hardness_median AS sqwh_hardness_median, hardness_min AS sqwh_hardness_min, hardness_max AS sqwh_hardness_max, classification AS sqwh_classification, appreciation AS sqwh_appreciation, geometry from sige.waterhardness where visible is true;
