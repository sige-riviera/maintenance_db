--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_hydrant.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_hydrant;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_hydrant AS
SELECT
    id,
    fk_district,
    fk_pressurezone,
    fk_printmap,
    _printmaps,
    -- _geometry_alt1_used,
    -- _geometry_alt2_used,
    -- _pipe_node_type,
    _pipe_orientation,
    _pipe_schema_visible,
    geometry,
    -- geometry_alt1,
    -- geometry_alt2,
    -- update_geometry_alt1,
    -- update_geometry_alt2,
    identification,
    fk_distributor,
    fk_status,
    fk_folder,
    fk_locationtype,
    fk_precision,
    fk_precisionalti,
    fk_object_reference,
    altitude,
    year,
    year_end,
    orientation,
    remark,
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
    fk_provider,
    fk_model_sup,
    fk_model_inf,
    fk_material,
    fk_output,
    underground,
    marked,
    pressure_static,
    pressure_dynamic,
    flow,
    observation_date,
    observation_source,
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
    district_name,
    district_shortname,
    district_zip,
    district_land_registry,
    district_prefix,
    -- district_colorcode,
    -- model_inf_vl_active,
    -- model_inf_short_fr,
    -- model_inf_short_en,
    -- model_inf_short_ro,
    model_inf_value_fr,
    -- model_inf_value_en,
    -- model_inf_value_ro,
    -- model_inf_description_fr,
    -- model_inf_description_en,
    -- model_inf_description_ro,
    -- pressurezone_fk_distributor,
    -- pressurezone_fk_consumptionzone,
    pressurezone_name,
    -- pressurezone_population,
    -- pressurezone_subscriber,
    pressurezone_colorcode,
    -- pressurezone__geometry_alt1_used,
    -- pressurezone__geometry_alt2_used,
    -- pressurezone_update_geometry_alt1,
    -- pressurezone_update_geometry_alt2,
    -- material_vl_active,
    -- material_short_fr,
    -- material_short_en,
    -- material_short_ro,
    material_value_fr,
    -- material_value_en,
    -- material_value_ro,
    -- material_description_fr,
    -- material_description_en,
    -- material_description_ro,
    -- material_pressure_nominal,
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
    -- model_sup_vl_active,
    -- model_sup_short_fr,
    -- model_sup_short_en,
    -- model_sup_short_ro,
    model_sup_value_fr,
    -- model_sup_value_en,
    -- model_sup_value_ro,
    -- model_sup_description_fr,
    -- model_sup_description_en,
    -- model_sup_description_ro,
    -- object_reference_vl_active,
    -- object_reference_short_fr,
    -- object_reference_short_en,
    -- object_reference_short_ro,
    -- object_reference_value_fr,
    -- object_reference_value_en,
    -- object_reference_value_ro,
    -- object_reference_description_fr,
    -- object_reference_description_en,
    -- object_reference_description_ro,
    -- provider_vl_active,
    -- provider_short_fr,
    -- provider_short_en,
    -- provider_short_ro,
    provider_value_fr,
    -- provider_value_en,
    -- provider_value_ro,
    -- provider_description_fr,
    -- provider_description_en,
    -- provider_description_ro,
    distributor_name,
    -- output_vl_active,
    -- output_short_fr,
    -- output_short_en,
    -- output_short_ro,
    output_value_fr,
    -- output_value_en,
    -- output_value_ro,
    -- output_description_fr,
    -- output_description_en,
    -- output_description_ro,
    folder_identification,
    folder_description,
    folder_date_start,
    folder_date_end,
    third_party_supply
    -- precisionalti_vl_active,
    -- precisionalti_short_fr,
    -- precisionalti_short_en,
    -- precisionalti_short_ro,
    -- precisionalti_value_fr,
    -- precisionalti_value_en,
    -- precisionalti_value_ro,
    -- precisionalti_description_fr,
    -- precisionalti_description_en,
    -- precisionalti_description_ro,
    -- precisionalti_code_sire
FROM qwat_od.vw_export_hydrant;

ALTER TABLE usr_cartoriviera.sige_qgis_qwat_hydrant ALTER COLUMN geometry TYPE geometry('point', 2056) USING ST_Force2D(geometry);

CREATE INDEX geoidx_sige_qgis_qwat_hydrant
ON usr_cartoriviera.sige_qgis_qwat_hydrant
USING gist (geometry);
