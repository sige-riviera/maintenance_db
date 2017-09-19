--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_node.sql


create schema if not exists cartoriviera;




drop table if exists cartoriviera.qwat_node;

create table cartoriviera.qwat_node as
select id, _pipe_node_type, _pipe_orientation, geometry
from qwat_od.node
where _pipe_node_type is not null;

alter table cartoriviera.qwat_node alter column geometry type geometry('point', 21781) using st_force2d(st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03')));
alter table cartoriviera.qwat_node alter column _pipe_node_type type text USING _pipe_node_type::text;
