--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_node.sql


create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_node;

create table usr_cartoriviera.sige_qgis_qwat_node as
select id, _pipe_node_type, _pipe_orientation, geometry
from qwat_od.node
where _pipe_node_type is not null;

alter table usr_cartoriviera.sige_qgis_qwat_node alter column _pipe_node_type type text USING _pipe_node_type::text;
alter table usr_cartoriviera.sige_qgis_qwat_node alter column geometry type geometry('point', 2056) using st_force2d(geometry);
