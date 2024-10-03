--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_valve.sql

create schema if not exists usr_cartoriviera;

drop table if exists usr_cartoriviera.sige_qgis_qwat_valve_mn95;

create table usr_cartoriviera.sige_qgis_qwat_valve_mn95 as
select
    id,
    fk_valve_type,
    fk_valve_function,
    fk_valve_actuation,
    fk_pipe,
    fk_handle_precision,
    fk_handle_precisionalti,
    fk_maintenance,
    fk_nominal_diameter,
    closed,
    networkseparation,
    -- handle_altitude,
    -- handle_geometry,
    fk_district,
    fk_pressurezone,
    fk_distributor,
    fk_precision,
    fk_precisionalti,
    fk_status,
    fk_object_reference,
    fk_folder,
    year,
    year_end,
    altitude,
    orientation,
    -- fk_locationtype,
    identification,
    remark,
    -- fk_printmap,
    -- _geometry_alt1_used,
    -- _geometry_alt2_used,
    -- _pipe_node_type,
    _pipe_orientation,
    _pipe_schema_visible,
    _printmaps,
    geometry,
    -- geometry_alt1,
    -- geometry_alt2,
    -- update_geometry_alt1,
    -- update_geometry_alt2,
    schema_force_visible,
    _schema_visible,
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
    -- status_vl_active,
    -- status_short_fr,
    -- status_short_en,
    -- status_short_ro,
    status_value_fr,
    -- status_value_en,
    -- status_value_ro,
    status_description_fr,
    -- status_description_en,
    -- status_description_ro,
    status_active,
    status_functional,
    -- status_code_sire,
    district_name,
    district_shortname,
    district_zip,
    district_land_registry,
    district_prefix,
    -- district_colorcode,
    -- pressurezone_fk_distributor,
    -- pressurezone_fk_consumptionzone,
    pressurezone_name,
    -- pressurezone_population,
    -- pressurezone_subscriber,
    -- pressurezone_colorcode,
    -- pressurezone__geometry_alt1_used,
    -- pressurezone__geometry_alt2_used,
    -- pressurezone_update_geometry_alt1,
    -- pressurezone_update_geometry_alt2,
    -- valve_function_vl_active,
    valve_function_short_fr,
    -- valve_function_short_en,
    -- valve_function_short_ro,
    valve_function_value_fr,
    -- valve_function_value_en,
    -- valve_function_value_ro,
    valve_function_description_fr,
    -- valve_function_description_en,
    -- valve_function_description_ro,
    -- valve_function_schema_visible,
    -- precision_vl_active,
    -- precision_short_fr,
    -- precision_short_en,
    -- precision_short_ro,
    precision_value_fr,
    -- precision_value_en,
    -- precision_value_ro,
    precision_description_fr,
    -- precision_description_en,
    -- precision_description_ro,
    -- precision_code_sire,
    distributor_name,
    -- valve_type_vl_active,
    valve_type_short_fr,
    -- valve_type_short_en,
    -- valve_type_short_ro,
    valve_type_value_fr,
    -- valve_type_value_en,
    -- valve_type_value_ro,
    valve_type_description_fr,
    -- valve_type_description_en,
    -- valve_type_description_ro,
    -- object_reference_vl_active,
    -- object_reference_short_fr,
    -- object_reference_short_en,
    -- object_reference_short_ro,
    object_reference_value_fr,
    -- object_reference_value_en,
    -- object_reference_value_ro,
    -- object_reference_description_fr,
    -- object_reference_description_en,
    -- object_reference_description_ro,
    -- valve_actuation_vl_active,
    valve_actuation_short_fr,
    -- valve_actuation_short_en,
    -- valve_actuation_short_ro,
    valve_actuation_value_fr,
    -- valve_actuation_value_en,
    -- valve_actuation_value_ro,
    -- valve_actuation_description_fr,
    -- valve_actuation_description_en,
    -- valve_actuation_description_ro,
    -- valve_actuation_schema_visible,
    folder_identification,
    folder_description,
    folder_date_start,
    folder_date_end,
    -- precisionalti_vl_active,
    -- precisionalti_short_fr,
    -- precisionalti_short_en,
    -- precisionalti_short_ro,
    precisionalti_value_fr,
    -- precisionalti_value_en,
    -- precisionalti_value_ro,
    -- precisionalti_description_fr,
    -- precisionalti_description_en,
    -- precisionalti_description_ro,
    -- precisionalti_code_sire
    nominal_diameter
from qwat_od.vw_export_valve;

alter table usr_cartoriviera.sige_qgis_qwat_valve_mn95 alter column geometry type geometry('point', 2056) using st_force2d(geometry);
