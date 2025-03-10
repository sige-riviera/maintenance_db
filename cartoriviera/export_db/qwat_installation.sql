-- PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f cartoriviera/export_db/qwat_installation.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_installation;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_installation AS
    SELECT
    '<a href=javascript:sitnExterns.openWindow("Ouvrage","https://map.cartoriviera.ch/static/cache/sige/gallery.html?type=ouvrage&ouvrage='||identification||'",600,600)>croquis/photos</a>' as lien,
    id,
    fk_district,
    fk_pressurezone,
    fk_printmap,
    _printmaps,
    _geometry_alt1_used,
    _geometry_alt2_used,
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
    installation_type,
    name,
    fk_parent,
    fk_remote,
    fk_watertype,
    parcel,
    eca,
    open_water_surface,
    geometry_polygon,
    fk_source_type,
    fk_source_quality,
    flow_lowest,
    flow_average,
    flow_concession,
    contract_end,
    gathering_chamber,
    fk_pump_type,
    fk_pipe_in,
    fk_pipe_out,
    fk_pump_operating,
    no_pumps,
    rejected_flow,
    manometric_height,
    fk_overflow,
    fk_tank_firestorage,
    storage_total,
    storage_supply,
    storage_fire,
    altitude_overflow,
    altitude_apron,
    height_max,
    fire_valve,
    fire_remote,
    _litrepercm,
    cistern1_fk_type,
    cistern1_dimension_1,
    cistern1_dimension_2,
    cistern1_storage,
    _cistern1_litrepercm,
    cistern2_fk_type,
    cistern2_dimension_1,
    cistern2_dimension_2,
    cistern2_storage,
    _cistern2_litrepercm,
    sanitization_uv,
    sanitization_chlorine_liquid,
    sanitization_chlorine_gas,
    sanitization_ozone,
    filtration_membrane,
    filtration_sandorgravel,
    flocculation,
    activatedcharcoal,
    settling,
    treatment_capacity,
    networkseparation,
    flow_meter,
    water_meter,
    manometer,
    depth,
    no_valves,
    fk_pressurecontrol_type,
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
    -- watertype_vl_active,
    -- watertype_short_fr,
    -- watertype_short_en,
    -- watertype_short_ro,
    -- watertype_value_fr,
    -- watertype_value_en,
    -- watertype_value_ro,
    -- watertype_description_fr,
    -- watertype_description_en,
    -- watertype_description_ro,
    -- watertype_code_sire,
    -- pump_type_vl_active,
    -- pump_type_short_fr,
    -- pump_type_short_en,
    -- pump_type_short_ro,
    pump_type_value_fr,
    -- pump_type_value_en,
    -- pump_type_value_ro,
    -- pump_type_description_fr,
    -- pump_type_description_en,
    -- pump_type_description_ro,
    -- pump_type_code_sire,
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
    -- cistern2_vl_active,
    -- cistern2_short_fr,
    -- cistern2_short_en,
    -- cistern2_short_ro,
    cistern2_value_fr,
    -- cistern2_value_en,
    -- cistern2_value_ro,
    -- cistern2_description_fr,
    -- cistern2_description_en,
    -- cistern2_description_ro,
    -- precision_vl_active,
    -- precision_short_fr,
    -- precision_short_en,
    -- precision_short_ro,
    -- precision_value_fr,
    -- precision_value_en,
    -- precision_value_ro,
    -- precision_description_fr,
    -- precision_description_en,
    -- precision_description_ro,
    -- precision_code_sire,
    -- tank_firestorage_vl_active,
    -- tank_firestorage_short_fr,
    -- tank_firestorage_short_en,
    -- tank_firestorage_short_ro,
    tank_firestorage_value_fr,
    -- tank_firestorage_value_en,
    -- tank_firestorage_value_ro,
    -- tank_firestorage_description_fr,
    -- tank_firestorage_description_en,
    -- tank_firestorage_description_ro,
    -- cistern1_vl_active,
    -- cistern1_short_fr,
    -- cistern1_short_en,
    -- cistern1_short_ro,
    cistern1_value_fr,
    -- cistern1_value_en,
    -- cistern1_value_ro,
    -- cistern1_description_fr,
    -- cistern1_description_en,
    -- cistern1_description_ro,
    -- source_type_vl_active,
    -- source_type_short_fr,
    -- source_type_short_en,
    -- source_type_short_ro,
    source_type_value_fr,
    -- source_type_value_en,
    -- source_type_value_ro,
    -- source_type_description_fr,
    -- source_type_description_en,
    -- source_type_description_ro,
    -- source_type_code_sire,
    -- source_quality_vl_active,
    -- source_quality_short_fr,
    -- source_quality_short_en,
    -- source_quality_short_ro,
    source_quality_value_fr,
    -- source_quality_value_en,
    -- source_quality_value_ro,
    -- source_quality_description_fr,
    -- source_quality_description_en,
    -- source_quality_description_ro,
    -- source_quality_code_sire,
    distributor_name,
    -- overflow_vl_active,
    -- overflow_short_fr,
    -- overflow_short_en,
    -- overflow_short_ro,
    overflow_value_fr,
    -- overflow_value_en,
    -- overflow_value_ro,
    -- overflow_description_fr,
    -- overflow_description_en,
    -- overflow_description_ro,
    -- pressurecontrol_type_vl_active,
    -- pressurecontrol_type_short_fr,
    -- pressurecontrol_type_short_en,
    -- pressurecontrol_type_short_ro,
    pressurecontrol_type_value_fr,
    -- pressurecontrol_type_value_en,
    -- pressurecontrol_type_value_ro,
    -- pressurecontrol_type_description_fr,
    -- pressurecontrol_type_description_en,
    -- pressurecontrol_type_description_ro,
    -- remote_vl_active,
    -- remote_short_fr,
    -- remote_short_en,
    -- remote_short_ro,
    remote_value_fr,
    -- remote_value_en,
    -- remote_value_ro,
    -- remote_description_fr,
    -- remote_description_en,
    -- remote_description_ro,
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
    folder_identification,
    folder_description,
    folder_date_start,
    folder_date_end,
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
    -- precisionalti_code_sire,
    -- pump_operating_vl_active,
    -- pump_operating_short_fr,
    -- pump_operating_short_en,
    -- pump_operating_short_ro,
    pump_operating_value_fr
    -- pump_operating_value_en,
    -- pump_operating_value_ro,
    -- pump_operating_description_fr,
    -- pump_operating_description_en,
    -- pump_operating_description_ro,
    -- pump_operating_code_sire
FROM qwat_od.vw_export_installation;

ALTER TABLE usr_cartoriviera.sige_qgis_qwat_installation ALTER COLUMN installation_type TYPE text USING installation_type::text;
ALTER TABLE usr_cartoriviera.sige_qgis_qwat_installation ALTER COLUMN geometry TYPE geometry('point', 2056) USING ST_Force2D(geometry);

CREATE INDEX geoidx_sige_qgis_qwat_installation
ON usr_cartoriviera.sige_qgis_qwat_installation
USING gist (geometry);
