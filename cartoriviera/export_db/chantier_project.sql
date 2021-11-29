create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_project_line;
drop table if exists usr_cartoriviera.sige_qgis_project_point;
drop table if exists usr_cartoriviera.sige_qgis_project_line_mn95;
drop table if exists usr_cartoriviera.sige_qgis_project_point_mn95;

create table usr_cartoriviera.sige_qgis_project_line_mn95 as
select id, type AS prj_line_type, specifications AS prj_line_specifications, plan_reference AS prj_line_plan_reference, plan_name AS prj_line_plan_name, plan_year AS prj_line_plan_year, remark AS prj_line_remark, date(updated_at) AS prj_line_updated_at, geometry from chantier.project_line where visibility_carto is true;

create table usr_cartoriviera.sige_qgis_project_point_mn95 as
select id, type AS prj_point_type, specifications AS prj_point_specifications, plan_reference AS prj_point_plan_reference, plan_name AS prj_point_plan_name, plan_year AS prj_point_plan_year, remark AS prj_point_remark, date(updated_at) AS prj_point_updated_at, geometry from chantier.project_point where visibility_carto is true;

create table usr_cartoriviera.sige_qgis_project_point as select * from usr_cartoriviera.sige_qgis_project_point_mn95;
create table usr_cartoriviera.sige_qgis_project_line as select * from usr_cartoriviera.sige_qgis_project_line_mn95;

alter table usr_cartoriviera.sige_qgis_project_point alter column geometry type geometry('point', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
alter table usr_cartoriviera.sige_qgis_project_line alter column geometry type geometry('lineString', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
