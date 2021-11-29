--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_node.sql


create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_node;
drop table if exists usr_cartoriviera.sige_qgis_qwat_node_mn95;

create table usr_cartoriviera.sige_qgis_qwat_node_mn95 as
select id, _pipe_node_type, _pipe_orientation, geometry
from qwat_od.node
where _pipe_node_type is not null;

alter table usr_cartoriviera.sige_qgis_qwat_node_mn95 alter column _pipe_node_type type text USING _pipe_node_type::text;
alter table usr_cartoriviera.sige_qgis_qwat_node_mn95 alter column geometry type geometry('point', 2056) using st_force2d(geometry);

create table usr_cartoriviera.sige_qgis_qwat_node as select * from usr_cartoriviera.sige_qgis_qwat_node_mn95;

alter table usr_cartoriviera.sige_qgis_qwat_node alter column geometry type geometry('point', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
