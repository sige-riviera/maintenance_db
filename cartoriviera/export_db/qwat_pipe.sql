--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_pipe.sql

create schema if not exists cartoriviera;

drop table if exists cartoriviera.sige_qgis_qwat_pipe;

create table cartoriviera.sige_qgis_qwat_pipe as
select
  id,
  fk_parent,
  fk_function,
  fk_installmethod,
  fk_material,
  fk_distributor,
  fk_precision,
  fk_bedding,
  fk_protection,
  fk_status,
  fk_watertype,
  fk_locationtype,
  fk_folder,
  year,
  year_rehabilitation,
  year_end,
  tunnel_or_bridge,
  pressure_nominal,
  remark,
  _valve_count,
  _valve_closed,
  -- schema_force_visible,
  _schema_visible,
  label_1_visible,
  label_1_text,
  label_2_visible,
  label_2_text,
  fk_node_a,
  fk_node_b,
  fk_district,
  fk_pressurezone,
  fk_printmap,
  _length2d,
  _length3d,
  _diff_elevation,
  _printmaps,
  -- pipe._geometry_alt1_used,
  -- pipe._geometry_alt2_used,
  -- pipe.update_geometry_alt1,
  -- pipe.update_geometry_alt2,
  -- geometry,
  -- pipe.geometry_alt1,
  -- pipe.geometry_alt2,
  geometry2d AS geometry,
  schema_visible,
-- status_vl_active,
-- status_short_fr,
-- status_short_en,
-- status_short_ro,
status_value_fr,
-- status_value_en,
-- status_value_ro,
-- status_description_fr,
-- status_description_en,
-- status_description_ro,
status_active,
status_functional,
-- status_code_sire,
-- installmethod_vl_active,
-- installmethod_short_fr,
-- installmethod_short_en,
-- installmethod_short_ro,
-- installmethod_value_fr,
-- installmethod_value_en,
-- installmethod_value_ro,
-- installmethod_description_fr,
-- installmethod_description_en,
-- installmethod_description_ro,
district_name,
-- district_shortname,
-- district_zip,
-- district_land_registry,
-- district_prefix,
-- district_colorcode,
-- pressurezone_fk_distributor,
-- pressurezone_fk_consumptionzone,
pressurezone_name,
pressurezone_population,
pressurezone_subscriber,
pressurezone_colorcode,
-- pressurezone__geometry_alt1_used,
-- pressurezone__geometry_alt2_used,
-- pressurezone_update_geometry_alt1,
-- pressurezone_update_geometry_alt2,
-- pipe_material_vl_active,
pipe_material_short_fr,
-- pipe_material_short_en,
-- pipe_material_short_ro,
-- pipe_material_value_fr,
-- pipe_material_value_en,
-- pipe_material_value_ro,
-- pipe_material_description_fr,
-- pipe_material_description_en,
-- pipe_material_description_ro,
pipe_material__displayname_fr,
-- pipe_material__displayname_en,
-- pipe_material__displayname_ro,
pipe_material_diameter,
pipe_material_diameter_nominal,
pipe_material_diameter_internal,
pipe_material_diameter_external,
-- pipe_material_code_sire,
pipe_material_pressure_nominal,
-- pipe_material_sdr,
-- pipe_material_wall_thickness,
-- pipe_material_sn,
-- precision_vl_active,
-- precision_short_fr,
-- precision_short_en,
-- precision_short_ro,
precision_value_fr,
-- precision_value_en,
-- precision_value_ro,
-- precision_description_fr,
-- precision_description_en,
-- precision_description_ro,
-- precision_code_sire,
-- pipe_function_vl_active,
-- pipe_function_short_fr,
-- pipe_function_short_en,
-- pipe_function_short_ro,
pipe_function_value_fr,
-- pipe_function_value_en,
-- pipe_function_value_ro,
-- pipe_function_description_fr,
-- pipe_function_description_en,
-- pipe_function_description_ro,
pipe_function_schema_visible,
pipe_function_major,
-- pipe_function_code_sire,
-- protection_vl_active,
-- protection_short_fr,
-- protection_short_en,
-- protection_short_ro,
protection_value_fr,
-- protection_value_en,
-- protection_value_ro,
-- protection_description_fr,
-- protection_description_en,
-- protection_description_ro,
distributor_name,
folder_identification,
folder_description,
folder_date_start,
folder_date_end
-- node_b_fk_district,
-- node_b_fk_pressurezone,
-- node_b_fk_printmap,
-- node_b__printmaps,
-- node_b__geometry_alt1_used,
-- node_b__geometry_alt2_used,
-- node_b__pipe_node_type,
-- node_b__pipe_orientation,
-- node_b__pipe_schema_visible,
-- node_b_update_geometry_alt1,
-- node_b_update_geometry_alt2,
-- node_a_fk_district,
-- node_a_fk_pressurezone,
-- node_a_fk_printmap,
-- node_a__printmaps,
-- node_a__geometry_alt1_used,
-- node_a__geometry_alt2_used,
-- node_a__pipe_node_type,
-- node_a__pipe_orientation,
-- node_a__pipe_schema_visible,
-- node_a_update_geometry_alt1,
-- node_a_update_geometry_alt2 
from qwat_od.vw_export_pipe;

alter table cartoriviera.sige_qgis_qwat_pipe alter column geometry type geometry('linestring', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
