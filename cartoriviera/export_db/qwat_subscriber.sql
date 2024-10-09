--PGSERVICE=qwat psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_subscriber.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_subscriber;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_subscriber AS
SELECT
    '<a href=javascript:sitnExterns.openWindow("Abonne","https://map.cartoriviera.ch/static/cache/sige/gallery.html?type=abonne&abonne='||identification||'&commune='||district_prefix||'",600,600)>croquis/photos</a>' as lien,
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
    -- schema_force_visible,
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
    fk_subscriber_type,
    fk_pipe,
    parcel,
    flow_current,
    flow_planned,
    -- status_vl_active,
    -- status_short_fr,
    -- status_short_en,
    -- status_short_ro,
    -- status_value_fr,
    -- status_value_en,
    -- status_value_ro,
    -- status_description_fr,
    -- status_description_en,
    -- status_description_ro,
    -- status_active,
    -- status_functional,
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
    -- -- subscriber_type_vl_active,
    -- subscriber_type_short_fr,
    -- subscriber_type_short_en,
    -- subscriber_type_short_ro,
    subscriber_type_value_fr,
    -- subscriber_type_value_en,
    -- subscriber_type_value_ro,
    -- subscriber_type_description_fr,
    -- subscriber_type_description_en,
    -- subscriber_type_description_ro,
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
    distributor_name,
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
    usr_external_meter,
    usr_external_meter_remark
FROM qwat_od.vw_export_subscriber;

ALTER TABLE usr_cartoriviera.sige_qgis_qwat_subscriber ALTER COLUMN geometry TYPE geometry('point', 2056) USING ST_Force2D(geometry);
