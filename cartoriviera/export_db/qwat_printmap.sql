--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_printmap.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_printmap_mn95;

create table usr_cartoriviera.sige_qgis_qwat_printmap_mn95 as
select
  id,
  name,
  fk_district,
  remark,
  version_date,
  print_scale,
  x_min,
  y_min,
  x_max,
  y_max,
  geometry,
  label_1_visible,
  label_1_x,
  label_1_y,
  label_1_rotation,
  label_1_text,
  label_2_visible,
  label_2_x,
  label_2_y,
  label_2_rotation,
  label_2_text,
  district_name,
  district_shortname,
  district_zip,
  district_land_registry,
  district_prefix,
  district_colorcode
from qwat_od.vw_export_printmap;
