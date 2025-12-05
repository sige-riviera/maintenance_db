-- PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f cartoriviera/export_db/qwat_pipe_schema.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_pipe_schema;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_pipe_schema AS
SELECT
    vw_pipe_schema.id,
    vw_pipe_schema.fk_function,
    --vw_pipe_schema.fk_install_method,
    vw_pipe_schema.fk_material,
    vw_pipe_schema.fk_distributor,
    --vw_pipe_schema.fk_precision,
    --vw_pipe_schema.fk_protection,
    vw_pipe_schema.fk_status,
    --vw_pipe_schema.fk_folder,
    --vw_pipe_schema.year,
    --vw_pipe_schema.year_end,
    --vw_pipe_schema.pressure_nominal,
    --vw_pipe_schema.remark,
    --vw_pipe_schema.fk_district,
    vw_pipe_schema.fk_pressurezone,
    --vw_pipe_schema.fk_printmap,
    --vw_pipe_schema._printmaps,
    --vw_pipe_schema.label_2_visible,
    --vw_pipe_schema.label_2_text,
    --vw_pipe_schema._pressurezone,
    --vw_pipe_schema._pressurezone_colorcode
    vw_pipe_schema.geometry,
    pipe_material.short_fr AS pipe_material_short_fr,
    pipe_material.diameter_internal AS pipe_material_diameter_internal,
    pipe.qwat_ext_ch_vd_sire_etat_exploitation,
    pipe.qwat_ext_ch_vd_sire_adesafecter,
    pipe.qwat_ext_ch_vd_sire_diametre
    --pipe.qwat_ext_ch_vd_sire_remarque 
FROM qwat_od.vw_pipe_schema -- There should be an export table for pipe schema, but this does not exist at the moment
    LEFT JOIN qwat_vl.pipe_material ON vw_pipe_schema.fk_material = pipe_material.id 
    LEFT JOIN qwat_od.pressurezone ON vw_pipe_schema.fk_pressurezone = pressurezone.id -- utile ??
    LEFT JOIN qwat_od.pipe ON vw_pipe_schema.id = pipe.id; 

CREATE INDEX geoidx_sige_qgis_qwat_pipe_schema
ON usr_cartoriviera.sige_qgis_qwat_pipe_schema
USING gist (geometry);
