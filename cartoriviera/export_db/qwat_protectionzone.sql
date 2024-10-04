--PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_croquis_reseau.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_protectionzone;

create table usr_cartoriviera.sige_qgis_qwat_protectionzone as
select *
from (SELECT protectionzone.id,
    protectionzone.fk_type,
    protectionzone.name,
    protectionzone.validated,
    protectionzone.date,
    protectionzone.agent,
    protectionzone.geometry,
    protectionzone_type.value_fr AS _type_long,
    protectionzone_type.short_fr AS _type
   FROM qwat_od.protectionzone
     JOIN qwat_vl.protectionzone_type ON protectionzone.fk_type = protectionzone_type.id ) as foo;
